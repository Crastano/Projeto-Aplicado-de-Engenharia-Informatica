import 'package:flutter/material.dart';
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';

class TarefaItem {
  const TarefaItem({
    required this.titulo,
    required this.dataHora,
    this.dataLimite,
    this.category,
    this.categoryBackground,
    this.categoryText,
    this.lembrete,
    this.periodicidade,
    this.notas,
    this.anexos,
    this.estaCompletado = false,
    this.estaAtrasado = false,
    this.estaRepetindo = false,
    this.temLembrete = false,
  });

  final String titulo;
  final DateTime dataHora;
  final DateTime? dataLimite;
  final String? category;
  final Color? categoryBackground;
  final Color? categoryText;
  final Lembrete? lembrete;
  final Periodicidade? periodicidade;
  final String? notas;
  final List<String>? anexos;
  final bool estaCompletado;
  final bool estaAtrasado;
  final bool estaRepetindo;
  final bool temLembrete;

  bool get temDataLimite => dataLimite != null;

  String get data {
    final dia = dataHora.day.toString().padLeft(2, '0');
    final mes = dataHora.month.toString().padLeft(2, '0');
    final hora = dataHora.hour.toString().padLeft(2, '0');
    final minuto = dataHora.minute.toString().padLeft(2, '0');

    return '$dia-$mes-${dataHora.year} $hora:$minuto';
  }

  TarefaItem copyWith({
    String? titulo,
    DateTime? dataHora,
    DateTime? dataLimite,
    bool removerDataLimite = false,
    String? category,
    Color? categoryBackground,
    Color? categoryText,
    Lembrete? lembrete,
    Periodicidade? periodicidade,
    String? notas,
    List<String>? anexos,
    bool? estaCompletado,
    bool? estaAtrasado,
    bool? estaRepetindo,
    bool? temLembrete,
  }) {
    return TarefaItem(
      titulo: titulo ?? this.titulo,
      dataHora: dataHora ?? this.dataHora,
      dataLimite: removerDataLimite ? null : dataLimite ?? this.dataLimite,
      category: category ?? this.category,
      categoryBackground: categoryBackground ?? this.categoryBackground,
      categoryText: categoryText ?? this.categoryText,
      lembrete: lembrete ?? this.lembrete,
      periodicidade: periodicidade ?? this.periodicidade,
      notas: notas ?? this.notas,
      anexos: anexos ?? this.anexos,
      estaCompletado: estaCompletado ?? this.estaCompletado,
      estaAtrasado: estaAtrasado ?? this.estaAtrasado,
      estaRepetindo: estaRepetindo ?? this.estaRepetindo,
      temLembrete: temLembrete ?? this.temLembrete,
    );
  }
}
