import 'package:flutter/material.dart';

// Enums
import 'package:pei/enums/filter_data.dart';
import 'package:pei/enums/filter_tarefa.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

class InicioControlador {
  FilterData dataSelecionada = .nenhuma;
  FilterTarefa filtroSelecionado = .todos;

  List<TarefaModelo> filtrarTarefas(Iterable<TarefaModelo> tarefas) {
    final resultado = tarefas.where((tarefa) {
      return passaFiltroData(tarefa) && passaFiltroEstado(tarefa);
    }).toList();

    resultado.sort((a, b) => a.dataHora.compareTo(b.dataHora));
    return resultado;
  }

  bool passaFiltroEstado(TarefaModelo tarefa) {
    return switch (filtroSelecionado) {
      .todos => true,
      .pendentes => !tarefa.estaCompletado && !tarefa.estaAtrasado,
      .atrasados => tarefa.estaAtrasado,
      .concluidos => tarefa.estaCompletado,
    };
  }

  bool passaFiltroData(TarefaModelo tarefa) {
    final hoje = DateTime.now();

    return switch (dataSelecionada) {
      .nenhuma => true,
      .ontem => mesmoDia(
        tarefa.dataHora,
        hoje.subtract(const Duration(days: 1)),
      ),
      .hoje => mesmoDia(tarefa.dataHora, hoje),
      .amanha => mesmoDia(tarefa.dataHora, hoje.add(const Duration(days: 1))),
      .mes =>
        tarefa.dataHora.year == hoje.year &&
            tarefa.dataHora.month == hoje.month,
      .ano => tarefa.dataHora.year == hoje.year,
    };
  }

  String dataLabel(FilterData selecionado) {
    return switch (selecionado) {
      .nenhuma => 'Nenhuma',
      .ontem => 'Ontem',
      .hoje => 'Hoje',
      .amanha => 'Amanhã',
      .mes => 'Mês',
      .ano => 'Ano',
    };
  }

  IconData retornarIcon(FilterData selecionado) {
    return switch (selecionado) {
      .nenhuma => Icons.block_outlined,
      .ontem => Icons.history_rounded,
      .hoje => Icons.today_outlined,
      .amanha => Icons.event_outlined,
      .mes => Icons.calendar_month_outlined,
      .ano => Icons.calendar_today_outlined,
    };
  }

  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String textoVazio(FilterTarefa filtro) {
    return switch (filtro) {
      .todos => 'Ainda não existem tarefas para mostrar.',
      .pendentes => 'Não existem tarefas pendentes.',
      .atrasados => 'Não existem tarefas atrasadas.',
      .concluidos => 'Não existem tarefas concluídas.',
    };
  }
}
