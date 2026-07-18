import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Widgets
import 'linha_hora_atual.dart';
import 'tarefa_timeline_card.dart';

class ColunaDia extends StatelessWidget {
  ColunaDia({
    super.key,
    required this.dia,
    required this.tarefas,
    required this.alturaHora,
    required this.mostrarBordaDireita,
    required this.largura,
    required this.umDia,
  });

  final DateTime dia;
  final List<TarefaItem> tarefas;
  final double alturaHora;
  final bool mostrarBordaDireita;
  final double largura;
  final bool umDia;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final alturaTotal = alturaHora * 24;

    return SizedBox(
      height: alturaTotal,
      child: Stack(
        clipBehavior: .hardEdge,
        children: [
          Column(
            children: List.generate(24, (index) {
              return Container(
                height: alturaHora,
                decoration: BoxDecoration(
                  border: Border(
                    top: index == 0
                        ? BorderSide.none
                        : BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: largura * 0.005,
                          ),
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: largura * 0.005,
                    ),
                    right: mostrarBordaDireita
                        ? BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: largura * 0.005,
                          )
                        : BorderSide.none,
                    bottom: index == 23
                        ? BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: largura * 0.005,
                          )
                        : BorderSide.none,
                  ),
                ),
              );
            }),
          ),

          ...tarefas.map((tarefa) {
            final top = controlador.calcularTopTarefa(tarefa, alturaHora);

            final alturaCard = controlador.calcularAlturaTarefa(
              tarefa,
              alturaHora,
            );

            if (alturaCard <= 0) {
              return const SizedBox.shrink();
            }

            return Positioned(
              top: top,
              left: largura * 0.015,
              right: largura * 0.015,
              height: alturaCard,
              child: TarefaTimelineCard(
                tarefa: tarefa,
                largura: largura,
                umDia: umDia,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/paginaTarefa',
                    arguments: tarefa.id,
                  );
                },
              ),
            );
          }),

          if (controlador.mesmoDia(dia, DateTime.now()))
            LinhaHoraAtual(alturaHora: alturaHora),
        ],
      ),
    );
  }
}
