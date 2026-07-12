import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

class CabecalhoUmDia extends StatefulWidget {
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
  State<CabecalhoUmDia> createState() => _CabecalhoUmDiaState();
}

class _CabecalhoUmDiaState extends State<CabecalhoUmDia> {
  @override
  Widget build(BuildContext context) {
    final CalendarioController controlador = CalendarioController();

    final hoje = DateTime.now();
    final larguraHoras = widget.largura * 0.15;

    final diaAtual = controlador.mesmoDia(widget.dia, hoje);

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
                          width: widget.largura * 0.005,
                        ),
                  right: diaAtual
                      ? BorderSide.none
                      : BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: widget.largura * 0.005,
                        ),
                ),
              ),
              child: Text(
                '${controlador.formatarData(widget.dia, true, false)} ${widget.dia.day}',
                style: TextStyle(
                  fontSize: widget.largura * 0.05,
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
