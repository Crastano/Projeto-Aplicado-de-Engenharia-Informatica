import 'package:flutter/material.dart';

class EstadoChip extends StatelessWidget {
  const EstadoChip({
    super.key,
    required this.texto,
    required this.corFundo,
    required this.corTexto,
    required this.largura,
  });

  final String texto;
  final Color corFundo;
  final Color corTexto;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: .symmetric(
        horizontal: largura * 0.04,
        vertical: largura * 0.02,
      ),
      shape: StadiumBorder(),
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
        width: largura * 0.005
      ),
      backgroundColor: corFundo,
      label: Text(
        texto,
        style: TextStyle(
          fontSize: largura * 0.0375,
          fontWeight: .w500,
          color: corTexto,
        ),
      ),
    );
  }
}