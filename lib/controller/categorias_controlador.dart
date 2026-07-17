import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/categoria_item.dart';

class CategoriasController extends ChangeNotifier {
  final List<CategoriaItem> categorias = [
    CategoriaItem(id: 'trabalho', nome: 'Trabalho', cor: coresCategorias[0]),
    CategoriaItem(id: 'pessoal', nome: 'Pessoal', cor: coresCategorias[1]),
    CategoriaItem(id: 'pagar', nome: 'Pagar', cor: coresCategorias[3]),
  ];

  bool adicionarCategoria({required String nome, required CategoriaCor cor}) {
    final nomeLimpo = nome.trim();

    if (nomeLimpo.isEmpty || nomeExiste(nomeLimpo)) {
      return false;
    }

    categorias.add(
      CategoriaItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nome: nomeLimpo,
        cor: cor,
      ),
    );

    notifyListeners();
    return true;
  }

  bool editarCategoria({
    required String id,
    required String nome,
    required CategoriaCor cor,
  }) {
    final nomeLimpo = nome.trim();

    if (nomeLimpo.isEmpty) {
      return false;
    }

    if (nomeExiste(nomeLimpo, ignorarId: id)) {
      return false;
    }

    final index = categorias.indexWhere((categoria) => categoria.id == id);

    if (index == -1) {
      return false;
    }

    categorias[index] = categorias[index].copyWith(nome: nomeLimpo, cor: cor);

    notifyListeners();
    return true;
  }

  void eliminarCategoria(String id) {
    categorias.removeWhere((categoria) => categoria.id == id);

    notifyListeners();
  }

  bool nomeExiste(String nome, {String? ignorarId}) {
    final nomeNormalizado = nome.trim().toLowerCase();

    return categorias.any((categoria) {
      return categoria.id != ignorarId &&
          categoria.nome.toLowerCase() == nomeNormalizado;
    });
  }
}
