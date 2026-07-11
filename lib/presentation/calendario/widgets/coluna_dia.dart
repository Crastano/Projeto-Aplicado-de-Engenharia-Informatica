import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_tres_dias_controller.dart';
import 'package:pei/controller/calendario_um_dia_controller.dart';

// Widgets personais
import 'package:pei/presentation/calendario/widgets/linha_hora_atual.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class ColunaDia extends StatefulWidget {
  const ColunaDia({
    super.key,
    required this.dia,
    required this.tarefas,
    required this.alturaHora,
    required this.mostrarBordaDireita,
    required this.largura,
    required this.umDia,
  });

  final DateTime dia;
  final List<EventoCalendario> tarefas;
  final double alturaHora;
  final bool mostrarBordaDireita;
  final double largura;
  final bool umDia;

  @override
  State<ColunaDia> createState() => _ColunaDiaState();
}

class _ColunaDiaState extends State<ColunaDia> {
  final CalendarioTresDiasController controladorTresDias =
      CalendarioTresDiasController();
  final CalendarioUmDiaController controladorUmDia =
      CalendarioUmDiaController();

  @override
  Widget build(BuildContext context) {
    final alturaTotal = widget.alturaHora * 24;

    return SizedBox(
      height: alturaTotal,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Column(
            children: List.generate(24, (index) {
              final BorderSide topBorder = index == 0
                  ? BorderSide.none
                  : BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    );
              final BorderSide bottomBorder = index == 23
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    )
                  : BorderSide.none;
              final BorderSide rightBorder = widget.mostrarBordaDireita
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    )
                  : BorderSide.none;

              return Container(
                height: widget.alturaHora,
                decoration: BoxDecoration(
                  border: Border(
                    top: topBorder,
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    ),
                    right: rightBorder,
                    bottom: bottomBorder,
                  ),
                ),
              );
            }),
          ),

          ...widget.tarefas.map(
            (tarefa) => widget.umDia
                ? controladorUmDia.posicionarTarefa(
                    tarefa,
                    alturaTotal,
                    widget.dia,
                    widget.alturaHora,
                    widget.largura,
                  )
                : controladorTresDias.posicionarTarefa(
                    tarefa,
                    alturaTotal,
                    widget.dia,
                    widget.alturaHora,
                    widget.largura,
                  ),
          ),

          if (widget.umDia
              ? controladorUmDia.mesmoDia(widget.dia, DateTime.now())
              : controladorTresDias.mesmoDia(widget.dia, DateTime.now()))
            LinhaHoraAtual(alturaHora: widget.alturaHora),
        ],
      ),
    );
  }
}
