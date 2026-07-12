import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

// Widgets partilhados
import 'package:pei/presentation/calendario/widgets/coluna_horas.dart';
import 'package:pei/presentation/calendario/widgets/coluna_dia.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class TimelineTresDia extends StatefulWidget {
  const TimelineTresDia({
    super.key,
    required this.dias,
    required this.tarefas,
    required this.alturaHora,
    required this.largura,
  });

  final List<DateTime> dias;
  final List<EventoCalendario> tarefas;
  final double alturaHora;
  final double largura;

  @override
  State<TimelineTresDia> createState() => _TimelineTresDiaState();
}

class _TimelineTresDiaState extends State<TimelineTresDia> {
  final CalendarioController controlador = CalendarioController();

  @override
  Widget build(BuildContext context) {
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

            ...List.generate(widget.dias.length, (index) {
              final dia = widget.dias[index];

              return Expanded(
                child: ColunaDia(
                  dia: dia,
                  tarefas: controlador.tarefasDoDia(dia, widget.tarefas),
                  alturaHora: widget.alturaHora,
                  mostrarBordaDireita: index == widget.dias.length - 1,
                  largura: widget.largura,
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
