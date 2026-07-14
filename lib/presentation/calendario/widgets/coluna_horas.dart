import 'package:flutter/material.dart';

class ColunaHoras extends StatelessWidget {
  const ColunaHoras({super.key, required this.alturaHora});

  final double alturaHora;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(25, (hora) {
        final top = hora == 0
            ? (hora * alturaHora)
            : hora == 24
            ? (hora * alturaHora) - 20
            : hora * alturaHora - 12.5;

        return Positioned(
          top: top,
          left: 0,
          right: 10,
          child: Text(
            '${hora.toString().padLeft(2, '0')}:00',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: .w500, fontSize: alturaHora * 0.25),
          ),
        );
      }),
    );
  }
}
