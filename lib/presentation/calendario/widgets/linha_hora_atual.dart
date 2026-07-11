import 'package:flutter/material.dart';
import 'dart:async';

class LinhaHoraAtual extends StatefulWidget {
  const LinhaHoraAtual({required this.alturaHora});

  final double alturaHora;

  @override
  State<LinhaHoraAtual> createState() => _LinhaHoraAtualState();
}

class _LinhaHoraAtualState extends State<LinhaHoraAtual> {
  Timer? timer;
  DateTime agora = DateTime.now();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;

      setState(() {
        agora = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cor = Theme.of(context).colorScheme.primary;

    final minutos = (agora.hour * 60) + agora.minute + (agora.second / 60);

    final top = (minutos / 60) * widget.alturaHora;

    return Positioned(
      top: top - 4,
      left: 0,
      right: 0,
      height: 8,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
          ),
          Expanded(child: Container(height: 2, color: cor)),
        ],
      ),
    );
  }
}
