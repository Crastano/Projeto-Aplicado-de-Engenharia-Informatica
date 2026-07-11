import 'package:flutter/material.dart';

class EventoCalendario {
  const EventoCalendario({
    required this.titulo,
    required this.inicio,
    required this.fim,
    this.corFundo,
    this.corTexto,
  });

  final String titulo;
  final DateTime inicio;
  final DateTime fim;
  final Color? corFundo;
  final Color? corTexto;
}
