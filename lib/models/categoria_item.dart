import 'package:flutter/material.dart';

class CategoriaCor {
  const CategoriaCor({
    required this.nome,
    required this.fundo,
    required this.texto,
  });

  final String nome;
  final Color fundo;
  final Color texto;
}

const List<CategoriaCor> coresCategorias = [
  CategoriaCor(
    nome: 'Azul',
    fundo: Color(0xFFDCEBFF),
    texto: Color(0xFF0A56C2),
  ),
  CategoriaCor(
    nome: 'Verde',
    fundo: Color(0xFFDCFCE7),
    texto: Color(0xFF166534),
  ),
  CategoriaCor(
    nome: 'Amarelo',
    fundo: Color(0xFFFFF3A9),
    texto: Color(0xFF8A6A00),
  ),
  CategoriaCor(
    nome: 'Rosa',
    fundo: Color(0xFFFFD8EA),
    texto: Color(0xFF9D174D),
  ),
  CategoriaCor(
    nome: 'Roxo',
    fundo: Color(0xFFEDE9FE),
    texto: Color(0xFF6D28D9),
  ),
  CategoriaCor(
    nome: 'Laranja',
    fundo: Color(0xFFFFE4C7),
    texto: Color(0xFF9A4D00),
  ),
  CategoriaCor(
    nome: 'Vermelho',
    fundo: Color(0xFFFFE0E0),
    texto: Color(0xFFB42318),
  ),
  CategoriaCor(
    nome: 'Ciano',
    fundo: Color(0xFFCFFAFE),
    texto: Color(0xFF0E7490),
  ),
  CategoriaCor(
    nome: 'Turquesa',
    fundo: Color(0xFFCCFBF1),
    texto: Color(0xFF0F766E),
  ),
  CategoriaCor(
    nome: 'Cinzento',
    fundo: Color(0xFFE5E7EB),
    texto: Color(0xFF374151),
  ),
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

  CategoriaItem copyWith({
    String? nome,
    CategoriaCor? cor,
  }) {
    return CategoriaItem(
      id: id,
      nome: nome ?? this.nome,
      cor: cor ?? this.cor,
    );
  }
}