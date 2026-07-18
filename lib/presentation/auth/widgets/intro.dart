import 'package:flutter/material.dart';

// Widgets
import 'bloco_texto.dart';

class Intro extends StatelessWidget {
  const Intro({super.key, required this.largura, required this.altura});

  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Organiza o teu dia',
                    style: TextStyle(
                      fontSize: largura * 0.08,
                      fontWeight: .w600,
                    ),
                  ),
                  SizedBox(height: altura * 0.01),
                  Text(
                    'Cria tarefas, acompanha prazos e planeia os teus dias através do calendário.',
                    style: TextStyle(
                      fontSize: largura * 0.04,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: largura * 0.04),
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/logo.png', fit: .contain),
            ),
          ],
        ),
        SizedBox(height: altura * 0.05),

        BlocoTexto(
          icone: Icons.task_alt_rounded,
          texto: 'Cria e organiza tarefas',
          largura: largura,
        ),

        SizedBox(height: altura * 0.015),

        BlocoTexto(
          icone: Icons.calendar_month_outlined,
          texto: 'Consulta as tarefas no calendário',
          largura: largura,
        ),

        SizedBox(height: altura * 0.015),

        BlocoTexto(
          icone: Icons.cloud_sync_outlined,
          texto: 'Sincroniza através do Google Drive',
          largura: largura,
        ),
      ],
    );
  }
}
