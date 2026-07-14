import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controller.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Widgets
import '../coluna_dia.dart';
import '../coluna_horas.dart';

class TimelineTresDia extends StatelessWidget {
  TimelineTresDia({
    super.key,
    required this.dias,
    required this.tarefas,
    required this.alturaHora,
    required this.largura,
  });

  final List<DateTime> dias;
  final List<TarefaItem> tarefas;
  final double alturaHora;
  final double largura;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final alturaTotal = alturaHora * 24;
    final larguraHoras = largura * 0.15;

    return SingleChildScrollView(
      child: SizedBox(
        height: alturaTotal,
        child: Row(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              width: larguraHoras,
              height: alturaTotal,
              child: ColunaHoras(alturaHora: alturaHora),
            ),
            ...List.generate(dias.length, (index) {
              final dia = dias[index];
              final tarefasDoDia = controlador.tarefasAgendadasDoDia(
                dia,
                tarefas,
              );

              return Expanded(
                child: ColunaDia(
                  dia: dia,
                  tarefas: tarefasDoDia,
                  alturaHora: alturaHora,
                  mostrarBordaDireita: index == dias.length - 1,
                  largura: largura,
                  umDia: false,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
