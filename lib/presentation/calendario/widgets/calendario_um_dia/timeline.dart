import 'package:flutter/material.dart';

import 'package:pei/controller/calendario_controlador.dart';
import 'package:pei/models/tarefa_item.dart';

import '../coluna_dia.dart';
import '../coluna_horas.dart';

class TimelineUmDia extends StatelessWidget {
  TimelineUmDia({
    super.key,
    required this.dia,
    required this.tarefas,
    required this.alturaHora,
    required this.largura,
  });

  final DateTime dia;
  final List<TarefaItem> tarefas;
  final double alturaHora;
  final double largura;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final alturaTotal = alturaHora * 24;
    final larguraHoras = largura * 0.15;

    final tarefasDoDia = controlador.tarefasAgendadasDoDia(dia, tarefas);

    return SizedBox(
      height: alturaTotal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: larguraHoras,
            height: alturaTotal,
            child: ColunaHoras(alturaHora: alturaHora),
          ),
          Expanded(
            child: ColunaDia(
              key: ValueKey<DateTime>(dia),
              dia: dia,
              tarefas: tarefasDoDia,
              alturaHora: alturaHora,
              mostrarBordaDireita: true,
              largura: largura,
              umDia: true,
            ),
          ),
        ],
      ),
    );
  }
}
