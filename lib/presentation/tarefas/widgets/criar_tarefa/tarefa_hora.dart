import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

class TarefaHora extends StatefulWidget {
  const TarefaHora({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaHora> createState() => _TarefaHoraState();
}

class _TarefaHoraState extends State<TarefaHora> {
  final TarefasControlador controlador = TarefasControlador();

  TimeOfDay? horaSelecionada;

  Future<void> selecionarHoraInicial() async {
    final TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
      horaSelecionada = horaEscolhida;
    });
  }

  void removerHora() {
    setState(() {
      horaSelecionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Row(
          children: [
            Icon(Icons.access_time_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Column(
              children: [
                Text(
                  'Hora',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: widget.largura * 0.045,
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
                  Theme.of(context).colorScheme.surface,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: widget.largura * 0.005,
                  ),
                ),
              ),
              child: Text(
                horaSelecionada == null
                    ? 'Adicionar'
                    : MaterialLocalizations.of(context).formatTimeOfDay(
                        horaSelecionada!,
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
