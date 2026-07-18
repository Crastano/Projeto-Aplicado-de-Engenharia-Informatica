import 'package:flutter/material.dart';

// Enums
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_lembrete.dart';
import 'package:pei/enums/unidade_periodicidade.dart';

class TarefaItem {
  const TarefaItem({
    required this.id,
    required this.titulo,
    required this.data,
    this.hora,
    this.dataLimite,
    this.categoryId,
    this.category,
    this.lembrete = .nenhum,
    this.lembreteQuantidade,
    this.lembreteUnidade,
    this.periodicidade = .nenhuma,
    this.periodicidadeIntervalo,
    this.periodicidadeUnidade,
    this.notas,
    this.anexos = const [],
    this.estaCompletado = false,
  });

  final String id;
  final String titulo;
  final DateTime data;
  final TimeOfDay? hora;
  final DateTime? dataLimite;
  final String? categoryId;
  final String? category;
  final Lembrete lembrete;
  final int? lembreteQuantidade;
  final UnidadeLembrete? lembreteUnidade;
  final Periodicidade periodicidade;
  final int? periodicidadeIntervalo;
  final UnidadePeriodicidade? periodicidadeUnidade;
  final String? notas;
  final List<String> anexos;
  final bool estaCompletado;

  bool get temHora => hora != null;
  bool get temDataLimite => dataLimite != null;
  bool get estaRepetindo => periodicidade != .nenhuma;
  bool get temLembrete => lembrete != .nenhum;

  DateTime get dataHora {
    if (hora == null) {
      return DateTime(data.year, data.month, data.day);
    }

    return DateTime(data.year, data.month, data.day, hora!.hour, hora!.minute);
  }

  bool get estaAtrasado {
    if (estaCompletado) return false;

    final DateTime agora = DateTime.now();

    final DateTime hoje = DateTime(agora.year, agora.month, agora.day);

    if (dataLimite != null) {
      final limite = DateTime(
        dataLimite!.year,
        dataLimite!.month,
        dataLimite!.day,
      );

      return limite.isBefore(hoje);
    }

    if (!temHora) {
      final DateTime dataDaTarefa = DateTime(data.year, data.month, data.day);

      return dataDaTarefa.isBefore(hoje);
    }

    return dataHora.isBefore(agora);
  }

  TarefaItem copyWith({
    String? titulo,
    DateTime? data,
    TimeOfDay? hora,
    bool removerHora = false,
    DateTime? dataLimite,
    bool removerDataLimite = false,
    String? categoryId,
    String? category,
    bool removerCategoria = false,
    Lembrete? lembrete,
    int? lembreteQuantidade,
    UnidadeLembrete? lembreteUnidade,
    bool removerConfiguracaoLembrete = false,
    Periodicidade? periodicidade,
    int? periodicidadeIntervalo,
    UnidadePeriodicidade? periodicidadeUnidade,
    bool removerConfiguracaoPeriodicidade = false,
    String? notas,
    bool removerNotas = false,
    List<String>? anexos,
    bool? estaCompletado,
  }) {
    return TarefaItem(
      id: id,
      titulo: titulo ?? this.titulo,
      data: data ?? this.data,
      hora: removerHora ? null : hora ?? this.hora,
      dataLimite: removerDataLimite ? null : dataLimite ?? this.dataLimite,
      categoryId: removerCategoria ? null : categoryId ?? this.categoryId,
      category: removerCategoria ? null : category ?? this.category,
      lembrete: lembrete ?? this.lembrete,
      lembreteQuantidade: removerConfiguracaoLembrete
          ? null
          : lembreteQuantidade ?? this.lembreteQuantidade,
      lembreteUnidade: removerConfiguracaoLembrete
          ? null
          : lembreteUnidade ?? this.lembreteUnidade,
      periodicidade: periodicidade ?? this.periodicidade,
      periodicidadeIntervalo: removerConfiguracaoPeriodicidade
          ? null
          : periodicidadeIntervalo ?? this.periodicidadeIntervalo,
      periodicidadeUnidade: removerConfiguracaoPeriodicidade
          ? null
          : periodicidadeUnidade ?? this.periodicidadeUnidade,
      notas: removerNotas ? null : notas ?? this.notas,
      anexos: anexos ?? this.anexos,
      estaCompletado: estaCompletado ?? this.estaCompletado,
    );
  }
}
