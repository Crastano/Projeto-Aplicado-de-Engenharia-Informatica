import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instancia = AppDatabase._();

  static const String nomeFicheiro = 'pei_tarefas.db';
  static const int versao = 2;
  static const int utilizadorLocalId = 1;

  Database? _database;

  Future<Database> get database async {
    final existente = _database;
    if (existente != null) return existente;

    final caminho = path.join(await getDatabasesPath(), nomeFicheiro);

    _database = await openDatabase(
      caminho,
      version: versao,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _criarTabelas,
      onUpgrade: _atualizarTarefas,
    );

    return _database!;
  }

  Future<void> _criarTabelas(Database db, int version) async {
    final batch = db.batch();

    batch.execute('''
      CREATE TABLE utilizadores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        tipo TEXT NOT NULL DEFAULT 'naoRegistado'
          CHECK (tipo IN ('naoRegistado', 'registado'))
      )
    ''');

    batch.execute('''
      CREATE TABLE preferencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        utilizador_id INTEGER NOT NULL UNIQUE,
        tema TEXT NOT NULL DEFAULT 'sistema'
          CHECK (tema IN ('claro', 'escuro', 'sistema')),
        idioma TEXT NOT NULL DEFAULT 'pt'
          CHECK (idioma IN ('pt', 'en')),
        notificacoes_ativas INTEGER NOT NULL DEFAULT 1
          CHECK (notificacoes_ativas IN (0, 1)),
        usar_cloud INTEGER NOT NULL DEFAULT 0
          CHECK (usar_cloud IN (0, 1)),
        lembretes_tarefas INTEGER NOT NULL DEFAULT 1
          CHECK (lembretes_tarefas IN (0, 1)),
        tarefas_atrasadas INTEGER NOT NULL DEFAULT 1
          CHECK (tarefas_atrasadas IN (0, 1)),
        som_notificacoes INTEGER NOT NULL DEFAULT 1
          CHECK (som_notificacoes IN (0, 1)),
        formato_24_horas INTEGER NOT NULL DEFAULT 1
          CHECK (formato_24_horas IN (0, 1)),
        primeiro_dia_semana TEXT NOT NULL DEFAULT 'Segunda-feira',
        formato_data TEXT NOT NULL DEFAULT 'dd/MM/yyyy',
        FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE categorias (
        id TEXT PRIMARY KEY,
        utilizador_id INTEGER NOT NULL,
        nome TEXT NOT NULL COLLATE NOCASE,
        cor_indice INTEGER NOT NULL DEFAULT 0
          CHECK (cor_indice BETWEEN 0 AND 9),
        FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id)
          ON DELETE CASCADE,
        UNIQUE (utilizador_id, nome)
      )
    ''');

    batch.execute('''
      CREATE TABLE tarefas (
        id TEXT PRIMARY KEY,
        utilizador_id INTEGER NOT NULL,
        categoria_id TEXT,
        titulo TEXT NOT NULL,
        data TEXT NOT NULL,
        hora_minutos INTEGER,
        data_limite TEXT,
        estado TEXT NOT NULL DEFAULT 'pendente'
          CHECK (estado IN ('pendente', 'concluida', 'atrasada', 'cancelada')),
        criado_em TEXT NOT NULL,
        FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id)
          ON DELETE CASCADE,
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
          ON DELETE SET NULL
      )
    ''');

    batch.execute('''
      CREATE TABLE lembretes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tarefa_id TEXT NOT NULL UNIQUE,
        tipo TEXT NOT NULL,
        unidade TEXT,
        quantidade INTEGER,
        FOREIGN KEY (tarefa_id) REFERENCES tarefas(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE periodicidades (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tarefa_id TEXT NOT NULL UNIQUE,
        tipo TEXT NOT NULL,
        unidade TEXT,
        intervalo INTEGER,
        FOREIGN KEY (tarefa_id) REFERENCES tarefas(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE notas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tarefa_id TEXT NOT NULL UNIQUE,
        notas TEXT NOT NULL,
        FOREIGN KEY (tarefa_id) REFERENCES tarefas(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE documentos_anexos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tarefa_id TEXT NOT NULL,
        nome_ficheiro TEXT NOT NULL,
        uri TEXT NOT NULL,
        FOREIGN KEY (tarefa_id) REFERENCES tarefas(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE repeticoes_tarefas (
        tarefa_origem_id TEXT PRIMARY KEY,
        tarefa_gerada_id TEXT NOT NULL UNIQUE,
        FOREIGN KEY (tarefa_origem_id) REFERENCES tarefas(id)
          ON DELETE CASCADE,
        FOREIGN KEY (tarefa_gerada_id) REFERENCES tarefas(id)
          ON DELETE CASCADE
      )
    ''');

    batch.execute('CREATE INDEX idx_tarefas_data ON tarefas(data)');
    batch.execute('CREATE INDEX idx_tarefas_estado ON tarefas(estado)');
    batch.execute(
      'CREATE INDEX idx_tarefas_categoria ON tarefas(categoria_id)',
    );
    batch.execute(
      'CREATE INDEX idx_documentos_tarefa ON documentos_anexos(tarefa_id)',
    );
    batch.execute(
      'CREATE INDEX idx_repeticoes_gerada '
      'ON repeticoes_tarefas(tarefa_gerada_id)',
    );

    batch.insert('utilizadores', {
      'id': utilizadorLocalId,
      'email': null,
      'tipo': 'naoRegistado',
    });

    batch.insert('preferencias', {
      'utilizador_id': utilizadorLocalId,
      'tema': 'sistema',
      'idioma': 'pt',
      'notificacoes_ativas': 1,
      'usar_cloud': 0,
      'lembretes_tarefas': 1,
      'tarefas_atrasadas': 1,
      'som_notificacoes': 1,
      'formato_24_horas': 1,
      'primeiro_dia_semana': 'Segunda-feira',
      'formato_data': 'dd/MM/yyyy',
    });

    const categoriasPadrao = [
      {'id': 'trabalho', 'nome': 'Trabalho', 'cor_indice': 0},
      {'id': 'financas', 'nome': 'Finanças', 'cor_indice': 1},
      {'id': 'pagar', 'nome': 'Pagar', 'cor_indice': 2},
    ];

    for (final categoria in categoriasPadrao) {
      batch.insert('categorias', {
        ...categoria,
        'utilizador_id': utilizadorLocalId,
      });
    }

    await batch.commit(noResult: true);
  }

  Future<void> _atualizarTarefas(
    Database db,
    int versaoAntiga,
    int versaoNova,
  ) async {
    if (versaoAntiga < 2) {
      await db.execute('''
        CREATE TABLE repeticoes_tarefas (
          tarefa_origem_id TEXT PRIMARY KEY,
          tarefa_gerada_id TEXT NOT NULL UNIQUE,
          FOREIGN KEY (tarefa_origem_id) REFERENCES tarefas(id)
            ON DELETE CASCADE,
          FOREIGN KEY (tarefa_gerada_id) REFERENCES tarefas(id)
            ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        CREATE INDEX idx_repeticoes_gerada
        ON repeticoes_tarefas(tarefa_gerada_id)
      ''');
    }
  }

  Future<void> fechar() async {
    final db = _database;
    _database = null;
    await db?.close();
  }
}
