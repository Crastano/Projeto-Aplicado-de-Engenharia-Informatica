// Modelos
import 'package:pei/models/tarefaItem.dart';

import 'package:pei/presentation/calendario/utils.dart';

class CalendarioController {
  List<TarefaItem> obterTarefasDoDia(DateTime day) {
    return kTarefas[day] ?? [];
  }

  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime normalizarData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  String mesTitulo(DateTime dia) {
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

    return '${meses[dia.month - 1]} ${dia.year}';
  }

  String formatarDataSelecionada(DateTime dia) {
    const diasSemana = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo',
    ];

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

    return '${diasSemana[dia.weekday - 1]}, ${dia.day} de ${meses[dia.month - 1]}';
  }
}
