import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class TarefaTimelineCard extends StatefulWidget {
  const TarefaTimelineCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.umDia,
  });

  final EventoCalendario tarefa;
  final double largura;
  final bool umDia;

  @override
  State<TarefaTimelineCard> createState() => _TarefaTimelineCardState();
}

class _TarefaTimelineCardState extends State<TarefaTimelineCard> {
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: .zero,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(widget.largura * 0.025),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline, // border color
          width: widget.largura * 0.005, //
        ),
      ),
      color: widget.tarefa.corFundo ?? Theme.of(context).colorScheme.surface,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: () {},
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool cardPequeno = constraints.maxHeight < widget.largura * 0.075;

            return Padding(
              padding: .symmetric(
                horizontal: widget.largura * 0.015,
                vertical: cardPequeno ? 3 : widget.largura * 0.015,
              ),
              child: Align(
                alignment: .topLeft,
                child: Text(
                  widget.tarefa.titulo,
                  style: TextStyle(
                    color:
                        widget.tarefa.corTexto ??
                        Theme.of(context).colorScheme.onSurface,
                    fontSize: widget.umDia ? widget.largura * 0.05 : widget.largura * 0.03,
                    fontWeight: .w600,
                    height: 1.05,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}