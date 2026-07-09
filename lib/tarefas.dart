import 'package:flutter/material.dart';
import 'package:pei/models/tarefaItem.dart';

class Tarefas123 {
  final List<TarefaItem> tarefas = [
    const TarefaItem(
      titulo: 'Pagar conta da luz',
      data: '27-01-2026 01:00',
      category: 'Pagar',
      categoryBackground: Color(0xFFFFDDF1),
      categoryText: Color(0xFFB83280),
    ),
    const TarefaItem(
      titulo: 'Projeto de Engenharia Informática',
      data: '18-07-2026 23:59',
      category: 'Trabalho',
      categoryBackground: Color(0xFFDCEBFF),
      categoryText: Color(0xFF0A56C2),
      hasNotification: true,
    ),
    const TarefaItem(
      titulo: 'Tomar comprimido',
      data: '16:00',
      category: 'Tarefa',
      categoryBackground: Color(0xFFE5E7EB),
      categoryText: Color(0xFF374151),
      isCompleted: true,
      isRepeating: true,
      hasNotification: true,
    ),
    const TarefaItem(
      titulo: 'Cortar cabelo',
      data: '21-10-2027 12:00',
      category: 'Evento',
      categoryBackground: Color(0xFFFEF3C7),
      categoryText: Color(0xFF92400E),
      hasNotification: true,
    ),
  ];
}