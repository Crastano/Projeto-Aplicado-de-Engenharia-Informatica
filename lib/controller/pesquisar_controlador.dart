import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_estado.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

class PesquisarControlador extends ChangeNotifier {
  PesquisarControlador({TarefasEstado? tarefasEstado})
    : _tarefasEstado = tarefasEstado ?? TarefasEstado.instancia {
    pesquisaControlador.addListener(aoAlterarPesquisa);
    _tarefasEstado.addListener(aoAlterarTarefas);
  }

  final TarefasEstado _tarefasEstado;
  final TextEditingController pesquisaControlador = TextEditingController();

  String? categoriaIdSelecionada;

  List<TarefaModelo> get tarefasFiltradas {
    final pesquisa = pesquisaControlador.text.trim().toLowerCase();
    final categoriaId = categoriaIdSelecionada;

    final resultado = _tarefasEstado.tarefas.where((TarefaModelo tarefa) {
      final tituloTarefa = tarefa.titulo.trim().toLowerCase();
      final correspondeAoNome =
          pesquisa.isEmpty || tituloTarefa.contains(pesquisa);
      final correspondeACategoria =
          categoriaId == null || tarefa.categoryId == categoriaId;

      return correspondeAoNome && correspondeACategoria;
    }).toList();

    resultado.sort((TarefaModelo a,TarefaModelo b) => a.dataHora.compareTo(b.dataHora));
    return resultado;
  }

  void selecionarCategoria(String? categoriaId) {
    if (categoriaIdSelecionada == categoriaId) return;

    categoriaIdSelecionada = categoriaId;
    notifyListeners();
  }

  void limparPesquisa() {
    pesquisaControlador.clear();
  }

  void aoAlterarPesquisa() {
    notifyListeners();
  }

  void aoAlterarTarefas() {
    notifyListeners();
  }

  @override
  void dispose() {
    _tarefasEstado.removeListener(aoAlterarTarefas);
    pesquisaControlador.removeListener(aoAlterarPesquisa);
    pesquisaControlador.dispose();
    super.dispose();
  }
}