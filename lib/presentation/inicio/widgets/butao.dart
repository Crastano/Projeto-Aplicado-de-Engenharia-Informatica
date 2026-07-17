import 'package:flutter/material.dart';

class Butao extends StatelessWidget {
  const Butao({
    super.key,
    required this.largura,
    required this.altura,
    required this.texto,
    required this.icon,
    required this.onPressed,
    this.preenchido = true,
  });

  final double largura;
  final double altura;
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;
  final bool preenchido;

  @override
  Widget build(BuildContext context) {
    final double alturaButao = altura * 0.1;

    return SizedBox(
      width: .infinity,
      height: alturaButao,
      child: preenchido
          ? ElevatedButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Icon(icon, size: alturaButao * 0.5),
                  SizedBox(width: largura * 0.04),
                  Flexible(
                    child: Text(
                      texto,
                      style: TextStyle(fontSize: alturaButao * 0.23),
                    ),
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: largura * 0.005,
                )
              ),
              child: Row(
                children: [
                  Icon(icon, size: alturaButao * 0.5),
                  SizedBox(width: largura * 0.04),
                  Flexible(
                    child: Text(
                      texto,
                      style: TextStyle(fontSize: alturaButao * 0.23),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
