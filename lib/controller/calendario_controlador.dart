import 'dart:math' as math;

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Utils
import 'package:pei/utils/formatador_data_hora.dart';

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

  List<TarefaModelo> tarefasDoDia(DateTime dia, List<TarefaModelo> tarefas) {
    final resultado = tarefas.where((tarefa) {
      return mesmoDia(tarefa.data, dia);
    }).toList();

    resultado.sort((a, b) {
      if (a.hora != null && b.hora != null) {
        final minutosA = a.hora!.hour * 60 + a.hora!.minute;

        final minutosB = b.hora!.hour * 60 + b.hora!.minute;

        return minutosA.compareTo(minutosB);
      }

      if (a.hora != null) {
        return -1;
      }

      if (b.hora != null) {
        return 1;
      }

      return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
    });

    return resultado;
  }

  List<TarefaModelo> tarefasAgendadasDoDia(
    DateTime dia,
    List<TarefaModelo> tarefas,
  ) {
    final resultado = tarefas.where((tarefa) {
      final pertenceAoDia = mesmoDia(tarefa.data, dia);

      return pertenceAoDia && tarefa.temHora;
    }).toList();

    resultado.sort((a, b) {
      return a.dataHora.compareTo(b.dataHora);
    });

    return resultado;
  }

  List<TarefaModelo> tarefasSemHoraDoDia(DateTime dia, List<TarefaModelo> tarefas) {
    final resultado = tarefas.where((tarefa) {
      final pertenceAoDia = mesmoDia(tarefa.data, dia);

      return pertenceAoDia && !tarefa.temHora;
    }).toList();

    resultado.sort((a, b) {
      return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
    });

    return resultado;
  }

  List<TarefaModelo> tarefasComDataLimiteNoDia(
    DateTime dia,
    List<TarefaModelo> tarefas,
  ) {
    final resultado = tarefas.where((tarefa) {
      final dataLimite = tarefa.dataLimite;

      return dataLimite != null && mesmoDia(dataLimite, dia);
    }).toList();

    resultado.sort((a, b) => a.dataLimite!.compareTo(b.dataLimite!));

    return resultado;
  }

  List<TarefaModelo> tarefasIndicadasNoDia(
    DateTime dia,
    List<TarefaModelo> tarefas,
  ) {
    return tarefas.where((tarefa) {
      final tarefaMarcada = mesmoDia(tarefa.data, dia);

      final terminaNesteDia =
          tarefa.dataLimite != null && mesmoDia(tarefa.dataLimite!, dia);

      return tarefaMarcada || terminaNesteDia;
    }).toList();
  }

  double calcularTopTarefa(TarefaModelo tarefa, double alturaHora) {
    final minutos = tarefa.dataHora.hour * 60 + tarefa.dataHora.minute;

    return (minutos / 60) * alturaHora;
  }

  double calcularAlturaTarefa(TarefaModelo tarefa, double alturaHora) {
    final alturaTotal = alturaHora * 24;
    final top = calcularTopTarefa(tarefa, alturaHora);

    final espacoDisponivel = alturaTotal - top;

    return math.max(0, math.min(alturaHora, espacoDisponivel));
  }

  String formatarHora(DateTime data) {
    return FormatadorDataHora.hora(data);
  }

  String formatarDataHora(DateTime data) {
    return FormatadorDataHora.dataHora(data);
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
