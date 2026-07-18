import 'package:flutter/material.dart';

import 'package:pei/theme/app_cores.dart';

class CategoriaCor {
  const CategoriaCor({required this.nome, required this.indice});

  final String nome;

  final int indice;

  Color fundo(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppCores.categoriaBackgroundEscuro[indice];
    }

    return AppCores.categoriaBackgroundClaro[indice];
  }

  Color texto(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppCores.categoriaTextoEscuro[indice];
    }

    return AppCores.categoriaTextoClaro[indice];
  }
}

const List<CategoriaCor> coresCategorias = [
  CategoriaCor(nome: 'Azul', indice: 0),
  CategoriaCor(nome: 'Ciano', indice: 1),
  CategoriaCor(nome: 'Rosa', indice: 2),
  CategoriaCor(nome: 'Magenta', indice: 3),
  CategoriaCor(nome: 'Roxo', indice: 4),
  CategoriaCor(nome: 'Índigo', indice: 5),
  CategoriaCor(nome: 'Laranja', indice: 6),
  CategoriaCor(nome: 'Amarelo', indice: 7),
  CategoriaCor(nome: 'Verde', indice: 8),
  CategoriaCor(nome: 'Cinzento', indice: 9),
];

class CategoriaItem {
  const CategoriaItem({
    required this.id,
    required this.nome,
    required this.cor,
  });

  final String id;
  final String nome;
  final CategoriaCor cor;

  CategoriaItem copyWith({String? nome, CategoriaCor? cor}) {
    return CategoriaItem(id: id, nome: nome ?? this.nome, cor: cor ?? this.cor);
  }
}
