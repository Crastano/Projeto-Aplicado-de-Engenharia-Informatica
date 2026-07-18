import 'package:flutter/material.dart';

import 'package:pei/controller/configuracoes_controlador.dart';
import 'package:pei/controller/tarefas_controlador.dart';

class TarefaHora extends StatelessWidget {
  const TarefaHora({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> selecionarHora(BuildContext context) async {
    final configuracoes = ConfiguracoesControlador.instancia;

    final horaEscolhida = await showTimePicker(
      context: context,
      initialTime: controlador.horaSelecionada ?? TimeOfDay(hour: 0, minute: 0),
      helpText: 'Selecionar hora',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: configuracoes.formato24Horas),
          child: child!,
        );
      },
    );

    if (horaEscolhida == null) {
      return;
    }

    controlador.selecionarHora(horaEscolhida);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final hora = controlador.horaSelecionada;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: largura * 0.012),
          child: Row(
            children: [
              Icon(Icons.access_time_outlined, size: largura * 0.075),
              SizedBox(width: largura * 0.04),
              Expanded(
                child: Text(
                  'Hora',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: largura * 0.045,
                  ),
                ),
              ),

              if (hora != null)
                IconButton(
                  tooltip: 'Remover hora',
                  onPressed: () {
                    controlador.selecionarHora(null);
                  },
                  icon: Icon(Icons.close_rounded),
                ),

              OutlinedButton(
                onPressed: () {
                  selecionarHora(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: largura * 0.005,
                    ),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.all(largura * 0.025),
                  ),
                ),
                child: Text(
                  hora == null
                      ? 'Adicionar'
                      : MaterialLocalizations.of(context).formatTimeOfDay(
                          hora,
                          alwaysUse24HourFormat:
                              ConfiguracoesControlador.instancia.formato24Horas,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
