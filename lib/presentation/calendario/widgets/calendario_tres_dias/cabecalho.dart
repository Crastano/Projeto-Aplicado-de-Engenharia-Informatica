import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

class CabecalhoTresDias extends StatefulWidget {
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
  State<CabecalhoTresDias> createState() => _CabecalhoTresDiasState();
}

class _CabecalhoTresDiasState extends State<CabecalhoTresDias> {
  @override
  Widget build(BuildContext context) {
    final CalendarioController controlador = CalendarioController();

    final hoje = DateTime.now();
    final larguraHoras = widget.largura * 0.15;

    return Container(
      height: widget.altura * 0.07,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: widget.largura * 0.005,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: larguraHoras),

          ...widget.dias.map((dia) {
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
                      width: widget.largura * 0.005,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controlador.formatarData(dia, true, false),
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
