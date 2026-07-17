import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

class CabecalhoUmDia extends StatelessWidget {
  const CabecalhoUmDia({
    super.key,
    required this.dia,
    required this.largura,
    required this.altura,
  });

  final DateTime dia;
  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    final CalendarioControlador controlador = CalendarioControlador();

    final hoje = DateTime.now();
    final larguraHoras = largura * 0.15;

    final diaAtual = controlador.mesmoDia(dia, hoje);

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

          Expanded(
            child: Container(
              alignment: .center,
              decoration: BoxDecoration(
                color: diaAtual
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                border: Border(
                  left: diaAtual
                      ? BorderSide.none
                      : BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: largura * 0.005,
                        ),
                  right: diaAtual
                      ? BorderSide.none
                      : BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: largura * 0.005,
                        ),
                ),
              ),
              child: Text(
                '${controlador.formatarData(dia, false, true, false)} ${dia.day}',
                style: TextStyle(
                  fontSize: largura * 0.05,
                  fontWeight: .w500,
                  color: diaAtual
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
