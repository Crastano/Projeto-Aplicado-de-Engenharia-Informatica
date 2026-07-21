import 'package:sqflite/sqflite.dart';

// Base de dados
import '../database/base_de_dados.dart';

// Modelos
import 'package:pei/models/categoria_modelo.dart';

class CategoriaRepositorio {
  Future<List<CategoriaModelo>> listar() async {
    final db = await AppDatabase.instancia.database;
    final linhas = await db.query(
      'categorias',
      where: 'utilizador_id = ?',
      whereArgs: [AppDatabase.utilizadorLocalId],
      orderBy: 'nome COLLATE NOCASE ASC',
    );

    return linhas.map(_mapear).toList(growable: false);
  }

  Future<void> inserir(CategoriaModelo categoria) async {
    final db = await AppDatabase.instancia.database;
    await db.insert('categorias', {
      'id': categoria.id,
      'utilizador_id': AppDatabase.utilizadorLocalId,
      'nome': categoria.nome,
      'cor_indice': categoria.cor.indice,
    }, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<bool> atualizar(CategoriaModelo categoria) async {
    final db = await AppDatabase.instancia.database;
    final alteradas = await db.update(
      'categorias',
      {'nome': categoria.nome, 'cor_indice': categoria.cor.indice},
      where: 'id = ? AND utilizador_id = ?',
      whereArgs: [categoria.id, AppDatabase.utilizadorLocalId],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return alteradas > 0;
  }

  Future<bool> eliminar(String id) async {
    final db = await AppDatabase.instancia.database;
    final eliminadas = await db.delete(
      'categorias',
      where: 'id = ? AND utilizador_id = ?',
      whereArgs: [id, AppDatabase.utilizadorLocalId],
    );

    return eliminadas > 0;
  }

  CategoriaModelo _mapear(Map<String, Object?> linha) {
    final indice = (linha['cor_indice'] as int?) ?? 0;
    final indiceSeguro = indice.clamp(0, coresCategorias.length - 1).toInt();

    return CategoriaModelo(
      id: linha['id']! as String,
      nome: linha['nome']! as String,
      cor: coresCategorias[indiceSeguro],
    );
  }
}
