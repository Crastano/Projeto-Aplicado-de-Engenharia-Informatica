import 'package:flutter/material.dart';
import 'dart:math' as math;

// Modelos
import 'package:pei/models/eventoCalendario.dart';

// Widgets partilhados
import 'package:pei/presentation/calendario/widgets/tarefa_timeline_card.dart';

class CalendarioUmDiaController {
  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime normalizarData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  String diasSemana(DateTime dia) {
    const diasSemana = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo',
    ];

    return '${diasSemana[dia.weekday - 1]} ${dia.day}';
  }

  List<EventoCalendario> tarefasDoDia(
    DateTime dia,
    List<EventoCalendario> tarefas,
  ) {
    final inicioDia = DateTime(dia.year, dia.month, dia.day);

    final fimDia = inicioDia.add(const Duration(days: 1));

    final resultado = tarefas.where((tarefa) {
      return tarefa.fim.isAfter(inicioDia) && tarefa.inicio.isBefore(fimDia);
    }).toList();

    resultado.sort((a, b) => a.inicio.compareTo(b.inicio));

    return resultado;
  }

  Widget posicionarTarefa(
    EventoCalendario tarefa,
    double alturaTotal,
    DateTime dia,
    double alturaHora,
    double largura,
  ) {
    final inicioDia = DateTime(dia.year, dia.month, dia.day);

    final fimDia = inicioDia.add(const Duration(days: 1));

    final inicioVisivel = tarefa.inicio.isBefore(inicioDia)
        ? inicioDia
        : tarefa.inicio;

    final fimVisivel = tarefa.fim.isAfter(fimDia) ? fimDia : tarefa.fim;

    final minutosInicio = inicioVisivel.difference(inicioDia).inMinutes;

    final duracaoMinutos = fimVisivel.difference(inicioVisivel).inMinutes;

    final top = (minutosInicio / 60) * alturaHora;

    final alturaCalculada = (duracaoMinutos / 60) * alturaHora;

    final espacoDisponivel = alturaTotal - top;

    final alturaCard = math
        .min(math.max(24.0, alturaCalculada), espacoDisponivel)
        .toDouble();

    if (duracaoMinutos <= 0 || alturaCard <= 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: top,
      left: 8,
      right: 4,
      height: alturaCard,
      child: TarefaTimelineCard(tarefa: tarefa, largura: largura, umDia: true),
    );
  }
}
