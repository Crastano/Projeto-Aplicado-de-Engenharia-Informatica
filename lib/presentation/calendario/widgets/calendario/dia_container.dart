import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiaContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Color corTexto;

    if (selecionado) {
      corTexto = Theme.of(context).colorScheme.onPrimary;
    } else if (hoje) {
      corTexto = Theme.of(context).colorScheme.primary;
    } else if (outside) {
      corTexto = Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
    } else {
      corTexto = Theme.of(context).colorScheme.onSurface;
    }

    return Center(
      child: Container(
        width: largura * 0.09,
        alignment: .center,
        decoration: BoxDecoration(
          shape: .circle,
          color: selecionado
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: hoje && !selecionado
              ? .all(
                  color: Theme.of(context).colorScheme.primary,
                  width: largura * 0.005,
                )
              : null,
        ),
        child: Text(
          '${dia.day}',
          style: TextStyle(
            fontSize: largura * 0.045,
            fontWeight: .w500,
            color: corTexto,
          ),
        ),
      ),
    );
  }
}
