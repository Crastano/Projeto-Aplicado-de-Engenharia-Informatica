import 'dart:collection';
import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_estado.dart';

// Modelos
import 'package:pei/models/categoria_modelo.dart';

class CategoriasControlador extends ChangeNotifier {
  CategoriasControlador._();

  static final CategoriasControlador instancia = CategoriasControlador._();

  factory CategoriasControlador() => instancia;

  final List<CategoriaModelo> _categorias = [
    CategoriaModelo(id: 'trabalho', nome: 'Trabalho', cor: coresCategorias[0]),
    CategoriaModelo(id: 'pessoal', nome: 'Pessoal', cor: coresCategorias[8]),
    CategoriaModelo(id: 'financas', nome: 'Finanças', cor: coresCategorias[7]),
    CategoriaModelo(id: 'saude', nome: 'Saúde', cor: coresCategorias[2]),
    CategoriaModelo(id: 'estudo', nome: 'Estudo', cor: coresCategorias[4]),
    CategoriaModelo(id: 'compras', nome: 'Compras', cor: coresCategorias[6]),
    CategoriaModelo(id: 'pagar', nome: 'Pagar', cor: coresCategorias[3]),
    CategoriaModelo(id: 'casa', nome: 'Casa', cor: coresCategorias[1]),
  ];

  UnmodifiableListView<CategoriaModelo> get categorias =>
      UnmodifiableListView<CategoriaModelo>(_categorias);

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

  bool adicionarCategoria({required String nome, required CategoriaCor cor}) {
    final nomeLimpo = nome.trim();

    if (nomeLimpo.isEmpty || nomeExiste(nomeLimpo)) return false;

    _categorias.add(
      CategoriaModelo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nome: nomeLimpo,
        cor: cor,
      ),
    );

    _ordenar();
    notifyListeners();
    return true;
  }

  bool editarCategoria({
    required String id,
    required String nome,
    required CategoriaCor cor,
  }) {
    final nomeLimpo = nome.trim();

    if (nomeLimpo.isEmpty || nomeExiste(nomeLimpo, ignorarId: id)) {
      return false;
    }

    final index = _categorias.indexWhere((categoria) => categoria.id == id);

    if (index == -1) return false;

    final categoriaAnterior = _categorias[index];
    final categoriaAtualizada = categoriaAnterior.copyWith(
      nome: nomeLimpo,
      cor: cor,
    );

    _categorias[index] = categoriaAtualizada;
    _ordenar();
    TarefasEstado.instancia.atualizarCategoria(
      categoriaAnterior,
      categoriaAtualizada,
    );
    notifyListeners();
    return true;
  }

  bool eliminarCategoria(String id) {
    final index = _categorias.indexWhere((categoria) => categoria.id == id);

    if (index == -1) return false;

    final categoria = _categorias.removeAt(index);
    TarefasEstado.instancia.removerCategoria(categoria);
    notifyListeners();
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
