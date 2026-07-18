import 'package:flutter/material.dart';

import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/models/tarefa_item.dart';
import 'package:pei/controller/categorias_controlador.dart';

List<TarefaItem> criarTarefasIniciais() {
  final DateTime hoje = DateTime.now();

  final categorias = CategoriasControlador.instancia;

  final trabalho = categorias.obterPorId('trabalho')!;
  final pessoal = categorias.obterPorId('pessoal')!;
  final financas = categorias.obterPorId('financas')!;
  final saude = categorias.obterPorId('saude')!;
  final estudo = categorias.obterPorId('estudo')!;
  final compras = categorias.obterPorId('compras')!;
  final casa = categorias.obterPorId('casa')!;

  return [
    TarefaItem(
      id: 'demo-pequeno-almoco',
      titulo: 'Tomar pequeno-almoço',

      data: DateTime(hoje.year, hoje.month, hoje.day),

      hora: const TimeOfDay(hour: 8, minute: 0),

      categoryId: pessoal.id,
      category: pessoal.nome,

      periodicidade: Periodicidade.diaria,
    ),

    TarefaItem(
      id: 'demo-reuniao-projeto',
      titulo: 'Reunião do projeto',

      data: DateTime(hoje.year, hoje.month, hoje.day),

      hora: const TimeOfDay(hour: 10, minute: 30),

      dataLimite: DateTime(hoje.year, hoje.month, hoje.day),

      categoryId: trabalho.id,
      category: trabalho.nome,

      lembrete: Lembrete.trintaMinutos,
    ),

    // Tarefa sem hora.
    TarefaItem(
      id: 'demo-comprar-alimentos',
      titulo: 'Comprar alimentos',

      data: DateTime(hoje.year, hoje.month, hoje.day),

      dataLimite: DateTime(hoje.year, hoje.month, hoje.day),

      categoryId: compras.id,
      category: compras.nome,
    ),

    TarefaItem(
      id: 'demo-treino',
      titulo: 'Treino no ginásio',

      data: DateTime(hoje.year, hoje.month, hoje.day),

      hora: const TimeOfDay(hour: 19, minute: 30),

      categoryId: saude.id,
      category: saude.nome,

      lembrete: Lembrete.umaHora,
      periodicidade: Periodicidade.semanal,
    ),

    // Tarefa sem hora.
    TarefaItem(
      id: 'demo-responder-emails',
      titulo: 'Responder aos emails',

      data: DateTime(hoje.year, hoje.month, hoje.day + 1),

      categoryId: trabalho.id,
      category: trabalho.nome,
    ),

    TarefaItem(
      id: 'demo-relatorio',
      titulo: 'Terminar relatório',

      data: DateTime(hoje.year, hoje.month, hoje.day + 1),

      hora: const TimeOfDay(hour: 11, minute: 30),

      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 1),

      categoryId: trabalho.id,
      category: trabalho.nome,

      lembrete: Lembrete.umaHora,
    ),

    TarefaItem(
      id: 'demo-consulta',
      titulo: 'Consulta médica',

      data: DateTime(hoje.year, hoje.month, hoje.day + 1),

      hora: const TimeOfDay(hour: 16, minute: 0),

      categoryId: saude.id,
      category: saude.nome,

      lembrete: Lembrete.umDia,
    ),

    // Tarefa sem hora.
    TarefaItem(
      id: 'demo-ler-livro',
      titulo: 'Ler um capítulo do livro',

      data: DateTime(hoje.year, hoje.month, hoje.day + 1),

      categoryId: estudo.id,
      category: estudo.nome,
    ),

    TarefaItem(
      id: 'demo-apresentacao',
      titulo: 'Preparar apresentação',

      data: DateTime(hoje.year, hoje.month, hoje.day + 2),

      hora: const TimeOfDay(hour: 8, minute: 30),

      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 2),

      categoryId: estudo.id,
      category: estudo.nome,

      lembrete: Lembrete.umaHora,
    ),

    TarefaItem(
      id: 'demo-almoco-amigos',
      titulo: 'Almoçar com amigos',

      data: DateTime(hoje.year, hoje.month, hoje.day + 2),

      hora: const TimeOfDay(hour: 13, minute: 0),

      categoryId: pessoal.id,
      category: pessoal.nome,
    ),
    
    TarefaItem(
      id: 'demo-eletricidade',
      titulo: 'Pagar conta da eletricidade',

      data: DateTime(hoje.year, hoje.month, hoje.day + 2),

      dataLimite: DateTime(hoje.year, hoje.month, hoje.day + 2),

      categoryId: financas.id,
      category: financas.nome,

      lembrete: Lembrete.umDia,
    ),

    TarefaItem(
      id: 'demo-organizar-quarto',
      titulo: 'Organizar o quarto',

      data: DateTime(hoje.year, hoje.month, hoje.day + 2),
    ),
  ];
}
