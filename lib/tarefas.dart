import 'package:flutter/material.dart';
import 'package:pei/models/tarefa_item.dart';

final DateTime hoje = DateTime.now();

class Tarefas123 {
  final List<TarefaItem> tarefas = [
    // Hoje
    TarefaItem(
      titulo: 'Tomar pequeno-almoço',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day, 8, 0),
      category: 'Pessoal',
      categoryBackground: const Color(0xFFFFE0B2),
      categoryText: const Color(0xFF8A4B00),
      estaRepetindo: true,
    ),

    TarefaItem(
      titulo: 'Reunião do projeto',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day, 10, 30),
      dataLimite: DateTime(hoje.year, hoje.month, hoje.day, 12, 0),
      category: 'Trabalho',
      categoryBackground: const Color(0xFFDCEBFF),
      categoryText: const Color(0xFF0A56C2),
      temLembrete: true,
    ),

    TarefaItem(
      titulo: 'Comprar alimentos',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day, 15, 0),
      dataLimite: DateTime(hoje.year, hoje.month, hoje.day, 18, 0),
      category: 'Compras',
      categoryBackground: const Color(0xFFE5F5E0),
      categoryText: const Color(0xFF287A28),
    ),

    TarefaItem(
      titulo: 'Treino no ginásio',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day, 19, 30),
      category: 'Saúde',
      categoryBackground: const Color(0xFFFFDDE5),
      categoryText: const Color(0xFFA52245),
      temLembrete: true,
    ),

    // Amanhã
    TarefaItem(
      titulo: 'Responder aos emails',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 1, 9, 0),
      category: 'Trabalho',
      categoryBackground: const Color(0xFFDCEBFF),
      categoryText: const Color(0xFF0A56C2),
    ),

    TarefaItem(
      titulo: 'Terminar relatório',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 1, 11, 30),
      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 1, 17, 0),
      category: 'Trabalho',
      categoryBackground: const Color(0xFFDCEBFF),
      categoryText: const Color(0xFF0A56C2),
      temLembrete: true,
    ),

    TarefaItem(
      titulo: 'Consulta médica',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 1, 16, 0),
      category: 'Saúde',
      categoryBackground: const Color(0xFFFFDDE5),
      categoryText: const Color(0xFFA52245),
      temLembrete: true,
    ),

    TarefaItem(
      titulo: 'Ler um capítulo do livro',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 1, 21, 0),
      category: 'Estudo',
      categoryBackground: const Color(0xFFE8DFFF),
      categoryText: const Color(0xFF5B2FA3),
    ),

    // Depois de amanhã
    TarefaItem(
      titulo: 'Preparar apresentação',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 2, 8, 30),
      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 2, 14, 0),
      category: 'Estudo',
      categoryBackground: const Color(0xFFE8DFFF),
      categoryText: const Color(0xFF5B2FA3),
      temLembrete: true,
    ),

    TarefaItem(
      titulo: 'Almoçar com amigos',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 2, 13, 0),
      category: 'Pessoal',
      categoryBackground: const Color(0xFFFFE0B2),
      categoryText: const Color(0xFF8A4B00),
    ),

    TarefaItem(
      titulo: 'Pagar conta da eletricidade',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 2, 17, 30),
      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 2, 23, 59),
      category: 'Finanças',
      categoryBackground: const Color(0xFFFFF3BF),
      categoryText: const Color(0xFF755A00),
      temLembrete: true,
    ),

    TarefaItem(
      titulo: 'Organizar o quarto',
      dataHora: DateTime(hoje.year, hoje.month, hoje.day + 2, 20, 0),
      category: 'Casa',
      categoryBackground: const Color(0xFFDDF4F1),
      categoryText: const Color(0xFF176B62),
    ),
  ];
}
