import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

class TarefaDataLimite extends StatelessWidget {
  const TarefaDataLimite({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> selecionarData(BuildContext context) async {
    final limiteAtual = controlador.dataLimiteSelecionada;
    final dataInicial =
        limiteAtual != null &&
            !DateTime(
              limiteAtual.year,
              limiteAtual.month,
              limiteAtual.day,
            ).isBefore(controlador.dataSelecionada)
        ? limiteAtual
        : controlador.dataSelecionada;

    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: dataInicial,
      firstDate: controlador.dataSelecionada,
      lastDate: DateTime(2100),
      helpText: 'Selecionar data limite',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );

    if (dataEscolhida != null) {
      controlador.selecionarDataLimite(dataEscolhida);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final data = controlador.dataLimiteSelecionada;

        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: largura * 0.075),
              SizedBox(width: largura * 0.04),
              Expanded(
                child: Text(
                  'Data limite',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: largura * 0.045,
                  ),
                ),
              ),
              if (data != null)
                IconButton(
                  tooltip: 'Remover data limite',
                  onPressed: () => controlador.selecionarDataLimite(null),
                  icon: Icon(Icons.close_rounded),
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
                  data == null ? 'Adicionar' : controlador.formatarData(data),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
