import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

class PesquisarController extends ChangeNotifier {
  PesquisarController({List<TarefaItem> tarefas = const []})
    : tarefas = List<TarefaItem>.from(tarefas) {
    pesquisaController.addListener(aoPesquisar);
  }

  final TextEditingController pesquisaController = TextEditingController();

  List<TarefaItem> tarefas;

  List<TarefaItem> get tarefasPesquisadas {
    final pesquisa = pesquisaController.text.trim().toLowerCase();

    if (pesquisa.isEmpty) {
      return tarefas;
    }

    return tarefas.where((tarefa) {
      return tarefa.titulo.toLowerCase().contains(pesquisa);
    }).toList();
  }

  void atualizarTarefas(List<TarefaItem> tarefas) {
    this.tarefas = List<TarefaItem>.from(tarefas);
    notifyListeners();
  }

  void limparPesquisa() {
    pesquisaController.clear();
  }

  void aoPesquisar() {
    notifyListeners();
  }

  @override
  void dispose() {
    pesquisaController.removeListener(aoPesquisar);
    pesquisaController.dispose();
    super.dispose();
  }
}
