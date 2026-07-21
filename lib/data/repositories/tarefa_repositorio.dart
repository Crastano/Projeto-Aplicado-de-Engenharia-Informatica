import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Base de dados
import 'package:pei/data/database/base_de_dados.dart';

// Enums
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_lembrete.dart';
import 'package:pei/enums/unidade_periodicidade.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

class TarefaRepositorio {
  Future<List<TarefaModelo>> listar() async {
    final db = await AppDatabase.instancia.database;

    final linhas = await db.rawQuery(
      '''
      SELECT
        t.id,
        t.titulo,
        t.data,
        t.hora_minutos,
        t.data_limite,
        t.estado,
        t.criado_em,
        t.categoria_id,
        c.nome AS categoria_nome,
        l.tipo AS lembrete_tipo,
        l.quantidade AS lembrete_quantidade,
        l.unidade AS lembrete_unidade,
        p.tipo AS periodicidade_tipo,
        p.intervalo AS periodicidade_intervalo,
        p.unidade AS periodicidade_unidade,
        n.notas AS notas_texto
      FROM tarefas t
      LEFT JOIN categorias c ON c.id = t.categoria_id
      LEFT JOIN lembretes l ON l.tarefa_id = t.id
      LEFT JOIN periodicidades p ON p.tarefa_id = t.id
      LEFT JOIN notas n ON n.tarefa_id = t.id
      WHERE t.utilizador_id = ?
      ORDER BY t.data ASC, COALESCE(t.hora_minutos, 1440) ASC, t.titulo ASC
    ''',
      [AppDatabase.utilizadorLocalId],
    );

    final anexosPorTarefa = await _listarAnexosPorTarefa(db);

    return linhas
        .map((linha) {
          final id = linha['id']! as String;
          return _mapearTarefa(linha, anexosPorTarefa[id] ?? const []);
        })
        .toList(growable: false);
  }

  Future<TarefaModelo?> obterPorId(String id) async {
    final tarefas = await listar();
    for (final tarefa in tarefas) {
      if (tarefa.id == id) return tarefa;
    }
    return null;
  }

  Future<void> inserir(TarefaModelo tarefa) async {
    final db = await AppDatabase.instancia.database;
    final anexosPreparados = await _prepararAnexos(tarefa.id, tarefa.anexos);

    try {
      await db.transaction((tx) async {
        await tx.insert(
          'tarefas',
          _mapaTarefa(tarefa),
          conflictAlgorithm: ConflictAlgorithm.abort,
        );
        await _guardarDependencias(tx, tarefa, anexosPreparados);
      });
    } catch (_) {
      await _eliminarFicheirosNovos(anexosPreparados, tarefa.anexos);
      rethrow;
    }
  }

  Future<bool> atualizar(TarefaModelo tarefa) async {
    final db = await AppDatabase.instancia.database;
    final anexosAntigos = await _listarUrisAnexos(db, tarefa.id);
    final anexosPreparados = await _prepararAnexos(tarefa.id, tarefa.anexos);

    try {
      final atualizada = await db.transaction((tx) async {
        final alteradas = await tx.update(
          'tarefas',
          _mapaTarefa(tarefa, incluirCriadoEm: false),
          where: 'id = ? AND utilizador_id = ?',
          whereArgs: [tarefa.id, AppDatabase.utilizadorLocalId],
        );

        if (alteradas == 0) return false;

        await _apagarDependencias(tx, tarefa.id);
        await _guardarDependencias(tx, tarefa, anexosPreparados);
        return true;
      });

      if (atualizada) {
        await _eliminarFicheirosRemovidos(anexosAntigos, anexosPreparados);
      } else {
        await _eliminarFicheirosNovos(anexosPreparados, tarefa.anexos);
      }

      return atualizada;
    } catch (_) {
      await _eliminarFicheirosNovos(anexosPreparados, tarefa.anexos);
      rethrow;
    }
  }

  Future<bool> eliminar(String id) async {
    final db = await AppDatabase.instancia.database;
    final anexos = await _listarUrisAnexos(db, id);

    final eliminadas = await db.delete(
      'tarefas',
      where: 'id = ? AND utilizador_id = ?',
      whereArgs: [id, AppDatabase.utilizadorLocalId],
    );

    if (eliminadas > 0) {
      await _eliminarFicheiros(anexos);
      return true;
    }

    return false;
  }

  Map<String, Object?> _mapaTarefa(
    TarefaModelo tarefa, {
    bool incluirCriadoEm = true,
  }) {
    final hora = tarefa.hora;
    final mapa = <String, Object?>{
      'utilizador_id': AppDatabase.utilizadorLocalId,
      'categoria_id': tarefa.categoryId,
      'titulo': tarefa.titulo,
      'data': _dataSql(tarefa.data),
      'hora_minutos': hora == null ? null : hora.hour * 60 + hora.minute,
      'data_limite': tarefa.dataLimite == null
          ? null
          : _dataSql(tarefa.dataLimite!),
      'estado': tarefa.estaCancelada
          ? 'cancelada'
          : tarefa.estaCompletado
          ? 'concluida'
          : 'pendente',
    };

    if (incluirCriadoEm) {
      mapa['id'] = tarefa.id;
      mapa['criado_em'] = (tarefa.criadoEm ?? DateTime.now()).toIso8601String();
    }

    return mapa;
  }

  Future<void> _guardarDependencias(
    Transaction tx,
    TarefaModelo tarefa,
    List<String> anexos,
  ) async {
    if (tarefa.lembrete != Lembrete.nenhum) {
      await tx.insert('lembretes', {
        'tarefa_id': tarefa.id,
        'tipo': tarefa.lembrete.name,
        'unidade': tarefa.lembreteUnidade?.name,
        'quantidade': tarefa.lembreteQuantidade,
      });
    }

    if (tarefa.periodicidade != Periodicidade.nenhuma) {
      await tx.insert('periodicidades', {
        'tarefa_id': tarefa.id,
        'tipo': tarefa.periodicidade.name,
        'unidade': tarefa.periodicidadeUnidade?.name,
        'intervalo': tarefa.periodicidadeIntervalo,
      });
    }

    final notas = tarefa.notas?.trim();
    if (notas != null && notas.isNotEmpty) {
      await tx.insert('notas', {'tarefa_id': tarefa.id, 'notas': notas});
    }

    for (final uri in anexos) {
      await tx.insert('documentos_anexos', {
        'tarefa_id': tarefa.id,
        'nome_ficheiro': path.basename(uri),
        'uri': uri,
      });
    }
  }

  Future<void> _apagarDependencias(Transaction tx, String tarefaId) async {
    await tx.delete('lembretes', where: 'tarefa_id = ?', whereArgs: [tarefaId]);
    await tx.delete(
      'periodicidades',
      where: 'tarefa_id = ?',
      whereArgs: [tarefaId],
    );
    await tx.delete('notas', where: 'tarefa_id = ?', whereArgs: [tarefaId]);
    await tx.delete(
      'documentos_anexos',
      where: 'tarefa_id = ?',
      whereArgs: [tarefaId],
    );
  }

  TarefaModelo _mapearTarefa(Map<String, Object?> linha, List<String> anexos) {
    final minutos = linha['hora_minutos'] as int?;
    final estado = linha['estado'] as String? ?? 'pendente';

    return TarefaModelo(
      id: linha['id']! as String,
      titulo: linha['titulo']! as String,
      data: DateTime.parse(linha['data']! as String),
      hora: minutos == null
          ? null
          : TimeOfDay(hour: minutos ~/ 60, minute: minutos % 60),
      dataLimite: linha['data_limite'] == null
          ? null
          : DateTime.parse(linha['data_limite']! as String),
      categoryId: linha['categoria_id'] as String?,
      category: linha['categoria_nome'] as String?,
      lembrete: _enumPorNome(
        Lembrete.values,
        linha['lembrete_tipo'] as String?,
        Lembrete.nenhum,
      ),
      lembreteQuantidade: linha['lembrete_quantidade'] as int?,
      lembreteUnidade: _enumPorNomeOuNull(
        UnidadeLembrete.values,
        linha['lembrete_unidade'] as String?,
      ),
      periodicidade: _enumPorNome(
        Periodicidade.values,
        linha['periodicidade_tipo'] as String?,
        Periodicidade.nenhuma,
      ),
      periodicidadeIntervalo: linha['periodicidade_intervalo'] as int?,
      periodicidadeUnidade: _enumPorNomeOuNull(
        UnidadePeriodicidade.values,
        linha['periodicidade_unidade'] as String?,
      ),
      notas: linha['notas_texto'] as String?,
      anexos: anexos,
      estaCompletado: estado == 'concluida',
      estaCancelada: estado == 'cancelada',
      criadoEm: DateTime.tryParse(linha['criado_em'] as String? ?? ''),
    );
  }

  Future<Map<String, List<String>>> _listarAnexosPorTarefa(Database db) async {
    final linhas = await db.rawQuery(
      '''
      SELECT d.tarefa_id, d.uri
      FROM documentos_anexos d
      INNER JOIN tarefas t ON t.id = d.tarefa_id
      WHERE t.utilizador_id = ?
      ORDER BY d.id ASC
    ''',
      [AppDatabase.utilizadorLocalId],
    );

    final resultado = <String, List<String>>{};
    for (final linha in linhas) {
      final tarefaId = linha['tarefa_id']! as String;
      final uri = linha['uri']! as String;
      resultado.putIfAbsent(tarefaId, () => <String>[]).add(uri);
    }
    return resultado;
  }

  Future<List<String>> _listarUrisAnexos(Database db, String tarefaId) async {
    final linhas = await db.query(
      'documentos_anexos',
      columns: ['uri'],
      where: 'tarefa_id = ?',
      whereArgs: [tarefaId],
      orderBy: 'id ASC',
    );

    return linhas
        .map((linha) => linha['uri']! as String)
        .toList(growable: false);
  }

  Future<List<String>> _prepararAnexos(
    String tarefaId,
    List<String> caminhos,
  ) async {
    if (caminhos.isEmpty) return const [];

    final documentos = await getApplicationDocumentsDirectory();
    final pasta = Directory(path.join(documentos.path, 'pei_anexos'));
    if (!await pasta.exists()) await pasta.create(recursive: true);

    final resultado = <String>[];
    for (var index = 0; index < caminhos.length; index++) {
      final caminho = caminhos[index];
      if (caminho.trim().isEmpty) continue;

      final origem = File(caminho);
      if (!await origem.exists()) continue;

      final normalizado = path.normalize(origem.path);
      final pastaNormalizada = path.normalize(pasta.path);
      if (path.isWithin(pastaNormalizada, normalizado)) {
        resultado.add(normalizado);
        continue;
      }

      final nomeSeguro = path
          .basename(origem.path)
          .replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
      final destino = path.join(
        pasta.path,
        '${tarefaId}_${DateTime.now().microsecondsSinceEpoch}_$index-$nomeSeguro',
      );

      final copia = await origem.copy(destino);
      resultado.add(copia.path);
    }

    return resultado;
  }

  Future<void> _eliminarFicheirosRemovidos(
    List<String> antigos,
    List<String> atuais,
  ) async {
    final conjuntoAtual = atuais.map(path.normalize).toSet();
    final removidos = antigos.where(
      (caminho) => !conjuntoAtual.contains(path.normalize(caminho)),
    );
    await _eliminarFicheiros(removidos);
  }

  Future<void> _eliminarFicheirosNovos(
    List<String> preparados,
    List<String> originais,
  ) async {
    final conjuntoOriginal = originais.map(path.normalize).toSet();
    final novos = preparados.where(
      (caminho) => !conjuntoOriginal.contains(path.normalize(caminho)),
    );
    await _eliminarFicheiros(novos);
  }

  Future<void> _eliminarFicheiros(Iterable<String> caminhos) async {
    for (final caminho in caminhos) {
      try {
        final ficheiro = File(caminho);
        if (await ficheiro.exists()) await ficheiro.delete();
      } catch (_) {}
    }
  }

  String _dataSql(DateTime data) {
    final ano = data.year.toString().padLeft(4, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final dia = data.day.toString().padLeft(2, '0');
    return '$ano-$mes-$dia';
  }

  T _enumPorNome<T extends Enum>(List<T> valores, String? nome, T padrao) {
    if (nome == null) return padrao;
    for (final valor in valores) {
      if (valor.name == nome) return valor;
    }
    return padrao;
  }

  T? _enumPorNomeOuNull<T extends Enum>(List<T> valores, String? nome) {
    if (nome == null) return null;
    for (final valor in valores) {
      if (valor.name == nome) return valor;
    }
    return null;
  }
}
