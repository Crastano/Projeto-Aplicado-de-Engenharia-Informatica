import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controller.dart';

// Widgets
import 'calendario_widget.dart';

class SeletorCalendarioExpansivel extends StatefulWidget {
  const SeletorCalendarioExpansivel({
    super.key,
    required this.dataSelecionada,
    required this.largura,
    required this.altura,
    required this.onDataSelecionada,
  });

  final DateTime dataSelecionada;
  final double largura;
  final double altura;
  final ValueChanged<DateTime> onDataSelecionada;

  @override
  State<SeletorCalendarioExpansivel> createState() =>
      _SeletorCalendarioExpansivelState();
}

class _SeletorCalendarioExpansivelState
    extends State<SeletorCalendarioExpansivel>
    with TickerProviderStateMixin {
  final CalendarioControlador controlador = CalendarioControlador();

  bool calendarioAberto = false;

  late DateTime dataSelecionada;
  late DateTime mesVisivel;

  @override
  void initState() {
    super.initState();

    dataSelecionada = controlador.normalizarData(widget.dataSelecionada);

    mesVisivel = dataSelecionada;
  }

  @override
  void didUpdateWidget(covariant SeletorCalendarioExpansivel oldWidget) {
    super.didUpdateWidget(oldWidget);

    final novaData = controlador.normalizarData(widget.dataSelecionada);

    if (!controlador.mesmoDia(novaData, dataSelecionada)) {
      dataSelecionada = novaData;
      mesVisivel = novaData;
    }
  }

  void alternarCalendario() {
    setState(() {
      calendarioAberto = !calendarioAberto;

      if (calendarioAberto) {
        mesVisivel = dataSelecionada;
      }
    });
  }

  void selecionarDia(DateTime diaSelecionado, DateTime diaFocado) {
    final novaData = controlador.normalizarData(diaSelecionado);

    setState(() {
      dataSelecionada = novaData;
      mesVisivel = diaFocado;
    });

    widget.onDataSelecionada(novaData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: .circular(widget.largura * 0.025),
            onTap: alternarCalendario,
            child: Padding(
              padding: .all(widget.largura * 0.025),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controlador.formatarData(mesVisivel, false, false, true),
                      style: TextStyle(
                        fontSize: widget.largura * 0.055,
                        fontWeight: .w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: calendarioAberto ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: widget.largura * 0.075,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            reverseDuration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            alignment: .topCenter,
            child: calendarioAberto
                ? Padding(
                    padding: .only(bottom: widget.largura * 0.04),
                    child: CalendarioWidget(
                      largura: widget.largura,
                      altura: widget.altura,
                      primeiroDia: DateTime(2000),
                      ultimoDia: DateTime(2100),
                      focusedDay: mesVisivel,
                      selectedDay: dataSelecionada,
                      noDiaSelecionado: selecionarDia,
                      headerVisibilidade: false,
                      marcaTarefa: false,
                    ),
                  )
                : const SizedBox(width: .infinity, height: 0),
          ),
        ),
      ],
    );
  }
}
