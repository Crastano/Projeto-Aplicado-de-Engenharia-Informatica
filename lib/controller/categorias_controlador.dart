import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// Controladores
import 'package:pei/controller/tarefas_estado.dart';

// Repositorio
import 'package:pei/data/repositories/categoria_repositorio.dart';

// Modelos
import 'package:pei/models/categoria_modelo.dart';

class CategoriasControlador extends ChangeNotifier {
  CategoriasControlador._();

  static final CategoriasControlador instancia = CategoriasControlador._();

  factory CategoriasControlador() => instancia;

  final CategoriaRepositorio _repositorio = CategoriaRepositorio();
  final List<CategoriaModelo> _categorias = [];

  bool _inicializado = false;

  UnmodifiableListView<CategoriaModelo> get categorias =>
      UnmodifiableListView<CategoriaModelo>(_categorias);

  Future<void> inicializar() async {
    if (_inicializado) return;
    _categorias
      ..clear()
      ..addAll(await _repositorio.listar());
    _ordenar();
    _inicializado = true;
    notifyListeners();
  }

  Future<void> recarregar() async {
    _categorias
      ..clear()
      ..addAll(await _repositorio.listar());
    _ordenar();
    notifyListeners();
  }

  CategoriaModelo? obterPorId(String? id) {
    if (id == null) return null;

    for (final categoria in _categorias) {
      if (categoria.id == id) return categoria;
    }

    return null;
  }

  CategoriaModelo? obterPorNome(String? nome) {
    if (nome == null) return null;

    final nomeNormalizado = nome.trim().toLowerCase();

    for (final categoria in _categorias) {
      if (categoria.nome.toLowerCase() == nomeNormalizado) return categoria;
    }

    return null;
  }

  Future<bool> adicionarCategoria({
    required String nome,
    required CategoriaCor cor,
  }) async {
    final nomeLimpo = nome.trim();
    if (nomeLimpo.isEmpty || nomeExiste(nomeLimpo)) return false;

    final categoria = CategoriaModelo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nome: nomeLimpo,
      cor: cor,
    );

    try {
      await _repositorio.inserir(categoria);
    } on DatabaseException {
      return false;
    }

    _categorias.add(categoria);
    _ordenar();
    notifyListeners();
    return true;
  }

  Future<bool> editarCategoria({
    required String id,
    required String nome,
    required CategoriaCor cor,
  }) async {
    final nomeLimpo = nome.trim();
    if (nomeLimpo.isEmpty || nomeExiste(nomeLimpo, ignorarId: id)) {
      return false;
    }

    final index = _categorias.indexWhere((categoria) => categoria.id == id);
    if (index == -1) return false;

    final categoriaAtualizada = _categorias[index].copyWith(
      nome: nomeLimpo,
      cor: cor,
    );

    try {
      final atualizada = await _repositorio.atualizar(categoriaAtualizada);
      if (!atualizada) return false;
    } on DatabaseException {
      return false;
    }

    _categorias[index] = categoriaAtualizada;
    _ordenar();
    notifyListeners();
    await TarefasEstado.instancia.recarregar();
    return true;
  }

  Future<bool> eliminarCategoria(String id) async {
    final index = _categorias.indexWhere((categoria) => categoria.id == id);
    if (index == -1) return false;

    final eliminada = await _repositorio.eliminar(id);
    if (!eliminada) return false;

    _categorias.removeAt(index);
    notifyListeners();

    await TarefasEstado.instancia.recarregar();
    return true;
  }

  bool nomeExiste(String nome, {String? ignorarId}) {
    final nomeNormalizado = nome.trim().toLowerCase();

    return _categorias.any((categoria) {
      return categoria.id != ignorarId &&
          categoria.nome.toLowerCase() == nomeNormalizado;
    });
  }

  void _ordenar() {
    _categorias.sort(
      (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()),
    );
  }
}
