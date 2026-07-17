import 'package:flutter/material.dart';

class BlocoTexto extends StatelessWidget {
  const BlocoTexto({
    super.key,
    required this.icone,
    required this.texto,
    required this.largura,
  });

  final IconData icone;
  final String texto;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: largura * 0.1,
          height: largura * 0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(largura * 0.025),
          ),
          child: Icon(
            icone,
            size: largura * 0.06,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        SizedBox(width: largura * 0.03),
        Expanded(
          child: Text(
            texto,
            style: TextStyle(
              fontSize: largura * 0.04,
              fontWeight: .w500,
            ),
          ),
        ),
      ],
    );
  }
}
