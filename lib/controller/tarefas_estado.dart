import 'dart:collection';
import 'package:flutter/material.dart';

// Repositorio
import 'package:pei/data/repositories/tarefa_repositorio.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

class TarefasEstado extends ChangeNotifier {
  TarefasEstado._();

  static final TarefasEstado instancia = TarefasEstado._();

  final TarefaRepositorio _repositorio = TarefaRepositorio();
  final List<TarefaModelo> _tarefas = [];

  bool _inicializado = false;

  UnmodifiableListView<TarefaModelo> get tarefas =>
      UnmodifiableListView<TarefaModelo>(_tarefas);

  Future<void> inicializar() async {
    if (_inicializado) return;

    _tarefas
      ..clear()
      ..addAll(await _repositorio.listar());

    _ordenar();
    _inicializado = true;
    notifyListeners();
  }

  Future<void> recarregar() async {
    _tarefas
      ..clear()
      ..addAll(await _repositorio.listar());
    _ordenar();
    notifyListeners();
  }

  TarefaModelo? obterPorId(String id) {
    for (final tarefa in _tarefas) {
      if (tarefa.id == id) return tarefa;
    }

    return null;
  }

  Future<bool> adicionar(TarefaModelo tarefa) async {
    if (_tarefas.any((item) => item.id == tarefa.id)) return false;

    await _repositorio.inserir(tarefa);
    await recarregar();
    return true;
  }

  Future<bool> atualizar(TarefaModelo tarefa) async {
    final index = _tarefas.indexWhere((item) => item.id == tarefa.id);
    if (index == -1) return false;

    final atualizada = await _repositorio.atualizar(tarefa);
    if (!atualizada) return false;

    await recarregar();
    return true;
  }

  Future<bool> eliminar(String id) async {
    final eliminada = await _repositorio.eliminar(id);
    if (!eliminada) return false;

    _tarefas.removeWhere((tarefa) => tarefa.id == id);
    notifyListeners();
    return true;
  }

  Future<bool> alternarConclusao(String id) async {
    final tarefa = obterPorId(id);
    if (tarefa == null) return false;

    return atualizar(
      tarefa.copyWith(
        estaCompletado: !tarefa.estaCompletado,
        estaCancelada: false,
      ),
    );
  }

  Future<bool> cancelar(String id) async {
    final tarefa = obterPorId(id);
    if (tarefa == null) return false;

    return atualizar(
      tarefa.copyWith(estaCompletado: false, estaCancelada: true),
    );
  }

  void _ordenar() {
    _tarefas.sort((a, b) => a.dataHora.compareTo(b.dataHora));
  }
}
