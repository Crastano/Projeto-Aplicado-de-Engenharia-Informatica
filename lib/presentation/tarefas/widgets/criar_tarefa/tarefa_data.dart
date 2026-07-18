import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

class TarefaData extends StatelessWidget {
  const TarefaData({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> selecionarData(BuildContext context) async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: controlador.dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Selecionar data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );

    if (dataEscolhida != null) controlador.selecionarData(dataEscolhida);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: largura * 0.075),
              SizedBox(width: largura * 0.04),
              Expanded(
                child: Text(
                  'Data',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: largura * 0.045,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => selecionarData(context),
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
                      width: largura * 0.005,
                    ),
                  ),
                ),
                child: Text(
                  controlador.formatarData(controlador.dataSelecionada),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
