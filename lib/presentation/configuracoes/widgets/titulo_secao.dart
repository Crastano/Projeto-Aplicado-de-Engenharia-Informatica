import 'package:flutter/material.dart';

class TituloSecao extends StatelessWidget {
  const TituloSecao({super.key, required this.texto, required this.largura});

  final String texto;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(largura * 0.02),
      child: Text(
        texto,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: .w500,
          fontSize: largura * 0.045,
        ),
      ),
    );
  }
}