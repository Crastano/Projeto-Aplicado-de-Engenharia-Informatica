// Modelos
import 'package:pei/models/tarefa_item.dart';

// Enums
import 'package:pei/enums/filter_data.dart';
import 'package:pei/enums/filter_tarefa.dart';

class HomeControlador {
  FilterData dataSelecionada = .nenhuma;
  FilterTarefa filtroSelecionado = .todos;

  List<TarefaItem> filtrarTarefas(List<TarefaItem> tarefas) {
    return tarefas.where((tarefa) {
      return passaFiltroData(tarefa) && passaFiltroEstado(tarefa);
    }).toList();
  }

  bool passaFiltroEstado(TarefaItem tarefa) {
    switch (filtroSelecionado) {
      case .todos:
        return true;

      case .pendentes:
        return !tarefa.estaCompletado;

      case .atrasados:
        return tarefa.estaAtrasado;

      case .concluidos:
        return tarefa.estaCompletado;
    }
  }

  bool passaFiltroData(TarefaItem tarefa) {
    if (dataSelecionada == .nenhuma) {
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
      case .nenhuma:
        return true;

      case .ontem:
        return mesmoDia(dataTarefa, ontem);

      case .hoje:
        return mesmoDia(dataTarefa, hoje);

      case .amanha:
        return mesmoDia(dataTarefa, amanha);

      case .mes:
        return dataTarefa.year == hoje.year && dataTarefa.month == hoje.month;

      case .ano:
        return dataTarefa.year == hoje.year;
    }
  }

  DateTime? parseData(String data) {
    final hoje = DateTime.now();

    if (!data.contains('-')) {
      return DateTime(hoje.year, hoje.month, hoje.day);
    }

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

  String dataLabel(FilterData selecionado) {
    switch (selecionado) {
      case .nenhuma:
        return 'Nenhuma';
      case .ontem:
        return 'Ontem';
      case .hoje:
        return 'Hoje';
      case .amanha:
        return 'Amanhã';
      case .mes:
        return 'Mês atual';
      case .ano:
        return 'Ano atual';
    }
  }

  bool mesmoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
