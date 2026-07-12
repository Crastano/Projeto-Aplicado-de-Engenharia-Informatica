import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

import 'package:pei/utils.dart';

class TarefaHora extends StatefulWidget {
  const TarefaHora({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaHora> createState() => _TarefaHoraState();
}

class _TarefaHoraState extends State<TarefaHora> {
  final TarefasController controlador = TarefasController();

  TimeOfDay horaInicialSelecionada = TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay horaFinalSelecionada = TimeOfDay.fromDateTime(
    DateTime.now().add(Duration(hours: 1)),
  );

  bool error = false;

  void validarHoras() {
    error = controlador.validarHoras(
      horaInicialSelecionada,
      horaFinalSelecionada,
    );
  }

  @override
  void initState() {
    validarHoras();

    super.initState();
  }

  Future<void> selecionarHoraInicial() async {
    final TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: horaInicialSelecionada,
      helpText: 'Selecionar hora',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (!mounted || horaEscolhida == null) return;

    setState(() {
      horaInicialSelecionada = horaEscolhida;
      validarHoras();
    });
  }

  Future<void> selecionarHoraFinal() async {
    final TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: horaFinalSelecionada,
      helpText: 'Selecionar hora',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (!mounted || horaEscolhida == null) return;

    setState(() {
      horaFinalSelecionada = horaEscolhida;
      validarHoras();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: error ? .start : .center,
          children: [
            Icon(Icons.access_time_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Hora',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: widget.largura * 0.045,
                  ),
                ),
                if (error)
                  SizedBox(
                    width: widget.largura * 0.5,
                    child: Text(
                      'A hora final deve ser posterior à hora inicial',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                        fontSize: widget.largura * 0.035,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            OutlinedButton(
              onPressed: selecionarHoraInicial,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  error
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.surface,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  error
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.onSurface,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: error
                        ? Theme.of(context).colorScheme.onError
                        : Theme.of(context).colorScheme.outline,
                    width: widget.largura * 0.005,
                  ),
                ),
              ),
              child: Text(
                MaterialLocalizations.of(context).formatTimeOfDay(
                  horaInicialSelecionada,
                  alwaysUse24HourFormat: true,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: selecionarHoraFinal,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.surface,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: widget.largura * 0.005,
                  ),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: Text(
                MaterialLocalizations.of(context).formatTimeOfDay(
                  horaFinalSelecionada,
                  alwaysUse24HourFormat: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
