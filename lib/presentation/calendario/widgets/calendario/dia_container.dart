import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiaContainer extends StatefulWidget {
  const DiaContainer({
    super.key,
    required this.context,
    required this.dia,
    required this.largura,
    this.selecionado = false,
    this.outside = false,
    this.hoje = false,
  });

  final BuildContext context;
  final DateTime dia;
  final double largura;
  final bool selecionado;
  final bool outside;
  final bool hoje;

  @override
  State<DiaContainer> createState() => _DiaContainerState();
}

class _DiaContainerState extends State<DiaContainer> {
  @override
  Widget build(BuildContext context) {
    Color corTexto;

    if (widget.selecionado) {
      corTexto = Theme.of(context).colorScheme.onPrimary;
    } else if (widget.hoje) {
      corTexto = Theme.of(context).colorScheme.primary;
    } else if (widget.outside) {
      corTexto = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);
    } else {
      corTexto = Theme.of(context).colorScheme.onSurface;
    }

    return Center(
      child: Container(
        width: widget.largura * 0.09,
        alignment: .center,
        decoration: BoxDecoration(
          shape: .circle,
          color: widget.selecionado
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: widget.hoje && !widget.selecionado
              ? .all(
                  color: Theme.of(context).colorScheme.primary,
                  width: widget.largura * 0.005,
                )
              : null,
        ),
        child: Text(
          '${widget.dia.day}',
          style: TextStyle(
            fontSize: widget.largura * 0.045,
            fontWeight: .w500,
            color: corTexto,
          ),
        ),
      ),
    );
  }
}
