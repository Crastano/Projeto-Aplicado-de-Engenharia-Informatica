import 'package:pei/models/tarefaItem.dart';

enum FilterData { nenhuma, ontem, hoje, amanha, mes, ano }

enum FilterTarefa { todos, pendentes, concluidos }

class TarefasController {
  FilterData dataSelecionada = FilterData.nenhuma;
  FilterTarefa filtroSelecionado = FilterTarefa.todos;

  List<TarefaItem> filtrarTarefas(List<TarefaItem> tarefas) {
    return tarefas.where((tarefa) {
      return passaFiltroData(tarefa) && passaFiltroEstado(tarefa);
    }).toList();
  }

  bool passaFiltroEstado(TarefaItem tarefa) {
    switch (filtroSelecionado) {
      case FilterTarefa.todos:
        return true;

      case FilterTarefa.pendentes:
        return !tarefa.isCompleted;

      case FilterTarefa.concluidos:
        return tarefa.isCompleted;
    }
  }

  bool passaFiltroData(TarefaItem tarefa) {
    if (dataSelecionada == FilterData.nenhuma) {
      return true;
    }

    final dataTarefa = parseData(tarefa.data);

    if (dataTarefa == null) {
      return true;
    }

    final hoje = DateTime.now();
    final ontem = hoje.subtract(const Duration(days: 1));
    final amanha = hoje.add(const Duration(days: 1));

    switch (dataSelecionada) {
      case FilterData.nenhuma:
        return true;

      case FilterData.ontem:
        return mesmoDia(dataTarefa, ontem);

      case FilterData.hoje:
        return mesmoDia(dataTarefa, hoje);

      case FilterData.amanha:
        return mesmoDia(dataTarefa, amanha);

      case FilterData.mes:
        return dataTarefa.year == hoje.year &&
            dataTarefa.month == hoje.month;

      case FilterData.ano:
        return dataTarefa.year == hoje.year;
    }
  }

  DateTime? parseData(String data) {
    final hoje = DateTime.now();

    // Exemplo: "16:00"
    if (!data.contains('-')) {
      return DateTime(hoje.year, hoje.month, hoje.day);
    }

    // Exemplo: "27-01-2026 01:00"
    final datePart = data.split(' ').first;
    final parts = datePart.split('-');

    if (parts.length != 3) {
      return null;
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return null;
    }

    return DateTime(year, month, day);
  }

  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}