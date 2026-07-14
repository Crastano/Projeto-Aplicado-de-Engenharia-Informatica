import 'dart:math' as math;

import 'package:pei/models/tarefa_item.dart';

class CalendarioControlador {
  DateTime normalizarData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime> diasVisiveis(DateTime dataInicial) {
    final inicio = normalizarData(dataInicial);

    return List.generate(3, (index) => inicio.add(Duration(days: index)));
  }

  List<TarefaItem> tarefasAgendadasDoDia(
    DateTime dia,
    List<TarefaItem> tarefas,
  ) {
    final resultado = tarefas
        .where((tarefa) => mesmoDia(tarefa.dataHora, dia))
        .toList();

    resultado.sort((a, b) => a.dataHora.compareTo(b.dataHora));

    return resultado;
  }

  List<TarefaItem> tarefasComDataLimiteNoDia(
    DateTime dia,
    List<TarefaItem> tarefas,
  ) {
    final resultado = tarefas.where((tarefa) {
      final dataLimite = tarefa.dataLimite;

      return dataLimite != null && mesmoDia(dataLimite, dia);
    }).toList();

    resultado.sort((a, b) => a.dataLimite!.compareTo(b.dataLimite!));

    return resultado;
  }

  List<TarefaItem> tarefasIndicadasNoDia(
    DateTime dia,
    List<TarefaItem> tarefas,
  ) {
    return tarefas.where((tarefa) {
      final tarefaMarcada = mesmoDia(tarefa.dataHora, dia);

      final terminaNesteDia =
          tarefa.dataLimite != null && mesmoDia(tarefa.dataLimite!, dia);

      return tarefaMarcada || terminaNesteDia;
    }).toList();
  }

  double calcularTopTarefa(TarefaItem tarefa, double alturaHora) {
    final minutos = tarefa.dataHora.hour * 60 + tarefa.dataHora.minute;

    return (minutos / 60) * alturaHora;
  }

  /// Cada tarefa ocupa exatamente uma hora.
  double calcularAlturaTarefa(TarefaItem tarefa, double alturaHora) {
    final alturaTotal = alturaHora * 24;
    final top = calcularTopTarefa(tarefa, alturaHora);

    final espacoDisponivel = alturaTotal - top;

    return math.max(0, math.min(alturaHora, espacoDisponivel));
  }

  String formatarHora(DateTime data) {
    final hora = data.hour.toString().padLeft(2, '0');

    final minuto = data.minute.toString().padLeft(2, '0');

    return '$hora:$minuto';
  }

  String formatarDataHora(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');

    final mes = data.month.toString().padLeft(2, '0');

    return '$dia/$mes/${data.year} '
        '${formatarHora(data)}';
  }

  String formatarData(
    DateTime data,
    bool mostrarDia,
    bool mostrarDiaSemana,
    bool mostrarAno,
  ) {
    const diasSemana = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo',
    ];

    const diasSemanaCurtos = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    if (mostrarDia && mostrarDiaSemana) {
      return '${diasSemana[data.weekday - 1]}, '
          '${data.day} de '
          '${meses[data.month - 1]}';
    }

    if (mostrarDiaSemana) {
      return diasSemanaCurtos[data.weekday - 1];
    }

    if (mostrarAno) {
      return '${meses[data.month - 1]} '
          '${data.year}';
    }

    return meses[data.month - 1];
  }
}
