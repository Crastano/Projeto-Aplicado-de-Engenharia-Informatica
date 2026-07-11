import 'package:flutter/material.dart';

class ColunaHoras extends StatefulWidget {
  const ColunaHoras({super.key, required this.alturaHora});

  final double alturaHora;

  @override
  State<ColunaHoras> createState() => _ColunaHorasState();
}

class _ColunaHorasState extends State<ColunaHoras> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List.generate(25, (hora) {
        final top = hora == 0
            ? (hora * widget.alturaHora)
            : hora == 24
            ? (hora * widget.alturaHora) - 20
            : hora * widget.alturaHora - 13;

        return Positioned(
          top: top,
          left: 0,
          right: 10,
          child: Text(
            '${hora.toString().padLeft(2, '0')}:00',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: .w500,
              fontSize: widget.alturaHora * 0.25,
            ),
          ),
        );
      }),
    );
  }
}
