import 'dart:collection';
import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/categoria_modelo.dart';
import 'package:pei/models/tarefa_modelo.dart';

import 'package:pei/tarefas.dart';

class TarefasEstado extends ChangeNotifier {
  TarefasEstado._() : _tarefas = criarTarefasIniciais();

  static final TarefasEstado instancia = TarefasEstado._();

  final List<TarefaModelo> _tarefas;

  UnmodifiableListView<TarefaModelo> get tarefas =>
      UnmodifiableListView<TarefaModelo>(_tarefas);

  TarefaModelo? obterPorId(String id) {
    for (final tarefa in _tarefas) {
      if (tarefa.id == id) return tarefa;
    }

    return null;
  }

  void adicionar(TarefaModelo tarefa) {
    if (_tarefas.any((item) => item.id == tarefa.id)) return;

    _tarefas.add(tarefa);
    _ordenar();
    notifyListeners();
  }

  bool atualizar(TarefaModelo tarefa) {
    final index = _tarefas.indexWhere((item) => item.id == tarefa.id);

    if (index == -1) return false;

    _tarefas[index] = tarefa;
    _ordenar();
    notifyListeners();
    return true;
  }

  bool eliminar(String id) {
    final removidas = _tarefas.where((tarefa) => tarefa.id == id).length;
    _tarefas.removeWhere((tarefa) => tarefa.id == id);

    if (removidas == 0) return false;

    notifyListeners();
    return true;
  }

  void atualizarCategoria(
    CategoriaModelo categoriaAnterior,
    CategoriaModelo categoriaAtualizada,
  ) {
    bool alterou = false;

    for (int index = 0; index < _tarefas.length; index++) {
      final tarefa = _tarefas[index];
      final usaCategoria = tarefa.categoryId == categoriaAnterior.id ||
          (tarefa.categoryId == null &&
              tarefa.category?.toLowerCase() ==
                  categoriaAnterior.nome.toLowerCase());

      if (!usaCategoria) continue;

      _tarefas[index] = tarefa.copyWith(
        categoryId: categoriaAtualizada.id,
        category: categoriaAtualizada.nome,
      );
      alterou = true;
    }

    if (alterou) notifyListeners();
  }

  void removerCategoria(CategoriaModelo categoria) {
    bool alterou = false;

    for (var index = 0; index < _tarefas.length; index++) {
      final tarefa = _tarefas[index];
      final usaCategoria = tarefa.categoryId == categoria.id ||
          (tarefa.categoryId == null &&
              tarefa.category?.toLowerCase() == categoria.nome.toLowerCase());

      if (!usaCategoria) continue;

      _tarefas[index] = tarefa.copyWith(removerCategoria: true);
      alterou = true;
    }

    if (alterou) notifyListeners();
  }

  bool alternarConclusao(String id) {
    final tarefa = obterPorId(id);

    if (tarefa == null) return false;

    return atualizar(
      tarefa.copyWith(estaCompletado: !tarefa.estaCompletado),
    );
  }

  void _ordenar() {
    _tarefas.sort((a, b) => a.dataHora.compareTo(b.dataHora));
  }
}
