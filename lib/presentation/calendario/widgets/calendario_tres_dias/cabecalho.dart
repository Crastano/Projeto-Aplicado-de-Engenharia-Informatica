import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

class CabecalhoTresDias extends StatelessWidget {
  const CabecalhoTresDias({
    super.key,
    required this.dias,
    required this.largura,
    required this.altura,
  });

  final List<DateTime> dias;
  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    final CalendarioControlador controlador = CalendarioControlador();

    final hoje = DateTime.now();
    final larguraHoras = largura * 0.15;

    return Container(
      height: altura * 0.07,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: largura * 0.005,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: larguraHoras),

          ...dias.map((dia) {
            final diaAtual = controlador.mesmoDia(dia, hoje);

            return Expanded(
              child: Container(
                alignment: .center,
                decoration: BoxDecoration(
                  color: diaAtual
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: largura * 0.005,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controlador.formatarData(dia, false, true, false),
                      style: TextStyle(
                        fontWeight: .w500,
                        color: diaAtual
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${dia.day}',
                      style: TextStyle(
                        fontWeight: .w500,
                        color: diaAtual
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
