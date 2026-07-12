import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

// Widgets personais
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/seletor_lembrete.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/seletor_lembrete_personalizada.dart';

class TarefaLembrete extends StatefulWidget {
  const TarefaLembrete({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaLembrete> createState() => _TarefaLembreteState();
}

class _TarefaLembreteState extends State<TarefaLembrete> {
  final TarefasController controlador = TarefasController();

  Lembrete lembreteSelecionado = .nenhum;

  Future<void> selecionarLembrete() async {
    final Lembrete? lembreteEscolhido = await showModalBottomSheet<Lembrete>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SeletorLembrete(
          largura: widget.largura,
          lembreteInicial: lembreteSelecionado,
        );
      },
    );

    if (!mounted || lembreteEscolhido == null) return;

    if (lembreteEscolhido == Lembrete.personalizada) {
      final ConfiguracaoLembrete? configuracao =
          await showModalBottomSheet<ConfiguracaoLembrete>(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) {
              return SeletorLembretePersonalizado(
                largura: widget.largura,
                configuracaoInicial:
                    controlador.configuracaoLembretePersonalizada,
              );
            },
          );

      if (!mounted || configuracao == null) return;

      setState(() {
        controlador.configuracaoLembretePersonalizada = configuracao;
        lembreteSelecionado = Lembrete.personalizada;
      });
      return;
    }

    setState(() {
      lembreteSelecionado = lembreteEscolhido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: widget.largura * 0.09,
            ),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Lembrete',
              style: TextStyle(
                fontWeight: .w500,
                fontSize: widget.largura * 0.045,
              ),
            ),
          ],
        ),
        Spacer(),
        Flexible(
          flex: 6,
          child: OutlinedButton(
            onPressed: selecionarLembrete,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.onSurface,
              ),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: widget.largura * 0.005,
                ),
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.all(widget.largura * 0.025),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  controlador.obterIconeLembrete(lembreteSelecionado),
                  size: widget.largura * 0.045,
                ),
                SizedBox(width: widget.largura * 0.015),
                Flexible(
                  child: Text(
                    controlador.formatarLembrete(lembreteSelecionado),
                  ),
                ),
                SizedBox(width: widget.largura * 0.01),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: widget.largura * 0.05,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
