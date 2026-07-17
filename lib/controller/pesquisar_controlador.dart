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

  String? categoriaSelecionada;

  List<TarefaItem> get tarefasFiltradas {
    final pesquisa = pesquisaController.text.trim().toLowerCase();

    final categoria = categoriaSelecionada?.trim().toLowerCase();

    return tarefas.where((tarefa) {
      final tituloTarefa = tarefa.titulo.trim().toLowerCase();

      final categoriaTarefa = tarefa.category?.trim().toLowerCase();

      final correspondeAoNome =
          pesquisa.isEmpty || tituloTarefa.contains(pesquisa);

      final correspondeACategoria =
          categoria == null || categoriaTarefa == categoria;

      return correspondeAoNome && correspondeACategoria;
    }).toList();
  }

  void selecionarCategoria(String? categoria) {
    categoriaSelecionada = categoria;
    notifyListeners();
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
