import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Enums
import 'package:pei/enums/periodicidade.dart';

// Widgets
import 'seletor_periodicidade.dart';
import 'seletor_periodicidade_personalizada.dart';

class TarefaPeriodicidade extends StatelessWidget {
  const TarefaPeriodicidade({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> selecionarPeriodicidade(BuildContext context) async {
    final escolhida = await showModalBottomSheet<Periodicidade>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SeletorPeriodicidade(
          controlador: controlador,
          largura: largura,
          periodicidadeInicial: controlador.periodicidadeSelecionada,
        );
      },
    );

    if (escolhida == null || !context.mounted) return;

    if (escolhida == Periodicidade.personalizada) {
      final configuracao =
          await showModalBottomSheet<ConfiguracaoPeriodicidade>(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) {
              return SeletorPeriodicidadePersonalizada(
                controlador: controlador,
                largura: largura,
                configuracaoInicial:
                    controlador.configuracaoPeriodicidadePersonalizada,
              );
            },
          );

      if (configuracao == null) return;

      controlador.selecionarPeriodicidade(
        Periodicidade.personalizada,
        configuracao: configuracao,
      );
      return;
    }

    controlador.selecionarPeriodicidade(escolhida);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final periodicidade = controlador.periodicidadeSelecionada;

        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Row(
            children: [
              Icon(Icons.repeat_outlined, size: largura * 0.075),
              SizedBox(width: largura * 0.04),
              Expanded(
                child: Text(
                  'Periodicidade',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: largura * 0.045,
                  ),
                ),
              ),
              Flexible(
                child: OutlinedButton.icon(
                  onPressed: () => selecionarPeriodicidade(context),
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
                    padding: WidgetStatePropertyAll(.all(largura * 0.025)),
                  ),
                  icon: Icon(
                    controlador.obterIconePeriodicidade(periodicidade),
                    size: largura * 0.045,
                  ),
                  label: Text(
                    controlador.formatarPeriodicidade(periodicidade),
                    overflow: .ellipsis,
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
