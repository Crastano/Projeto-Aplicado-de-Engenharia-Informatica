import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key, required this.largura, required this.altura});

  final double largura;
  final double altura;

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Olá!',
                style: TextStyle(
                  fontSize: widget.largura * 0.1,
                  fontWeight: .w600,
                ),
              ),
              SizedBox(height: widget.altura * 0.025),
              Text(
                'Ao criar conta, podes usar a cloud para sincronizar as tuas tarefas online.',
                style: TextStyle(fontSize: widget.largura * 0.05, height: 1.2),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Image.asset('assets/images/logo.png', fit: .contain),
        ),
      ],
    );
  }
}