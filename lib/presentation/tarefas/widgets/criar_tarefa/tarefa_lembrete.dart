import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Enums
import 'package:pei/enums/lembrete.dart';

// Widgets
import 'seletor_lembrete.dart';
import 'seletor_lembrete_personalizada.dart';

class TarefaLembrete extends StatelessWidget {
  const TarefaLembrete({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> selecionarLembrete(BuildContext context) async {
    final escolhido = await showModalBottomSheet<Lembrete>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SeletorLembrete(
          controlador: controlador,
          largura: largura,
          lembreteInicial: controlador.lembreteSelecionado,
        );
      },
    );

    if (escolhido == null || !context.mounted) return;

    if (escolhido == .personalizada) {
      final configuracao = await showModalBottomSheet<ConfiguracaoLembrete>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        builder: (context) {
          return SeletorLembretePersonalizado(
            controlador: controlador,
            largura: largura,
            configuracaoInicial: controlador.configuracaoLembretePersonalizada,
          );
        },
      );

      if (configuracao == null) return;

      controlador.selecionarLembrete(
        .personalizada,
        configuracao: configuracao,
      );
      return;
    }

    controlador.selecionarLembrete(escolhido);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final lembrete = controlador.lembreteSelecionado;

        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Row(
            children: [
              Icon(Icons.notifications_none_outlined, size: largura * 0.075),
              SizedBox(width: largura * 0.04),
              Expanded(
                child: Text(
                  'Lembrete',
                  style: TextStyle(
                    fontWeight: .w500,
                    fontSize: largura * 0.045,
                  ),
                ),
              ),
              Flexible(
                child: OutlinedButton.icon(
                  onPressed: () => selecionarLembrete(context),
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
                  icon: Icon(
                    controlador.obterIconeLembrete(lembrete),
                    size: largura * 0.045,
                  ),
                  label: Text(
                    controlador.formatarLembrete(lembrete),
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
