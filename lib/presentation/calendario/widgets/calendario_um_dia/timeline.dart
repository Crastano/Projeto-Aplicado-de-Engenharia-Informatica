import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_um_dia_controller.dart';

// Widgets
import 'package:pei/presentation/calendario/widgets/coluna_dia.dart';
import 'package:pei/presentation/calendario/widgets/coluna_horas.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class TimelineUmDia extends StatefulWidget {
  const TimelineUmDia({
    super.key,
    required this.dia,
    required this.tarefas,
    required this.alturaHora,
    required this.largura,
  });

  final DateTime dia;
  final List<EventoCalendario> tarefas;
  final double alturaHora;
  final double largura;

  @override
  State<TimelineUmDia> createState() => _TimelineUmDiaState();
}

class _TimelineUmDiaState extends State<TimelineUmDia> {
  @override
  Widget build(BuildContext context) {
    final CalendarioUmDiaController controlador = CalendarioUmDiaController();

    final alturaTotal = widget.alturaHora * 24;
    final larguraHoras = widget.largura * 0.15;

    return SingleChildScrollView(
      child: SizedBox(
        height: alturaTotal,
        child: Row(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              width: larguraHoras,
              height: alturaTotal,
              child: ColunaHoras(alturaHora: widget.alturaHora),
            ),

            Expanded(
              child: ColunaDia(
                key: ValueKey<DateTime>(widget.dia),
                dia: widget.dia,
                tarefas: controlador.tarefasDoDia(widget.dia, widget.tarefas),
                alturaHora: widget.alturaHora,
                mostrarBordaDireita: true,
                largura: widget.largura,
                umDia: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
