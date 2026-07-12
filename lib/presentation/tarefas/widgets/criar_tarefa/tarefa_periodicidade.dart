import 'package:flutter/material.dart';

// Widgets personais
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/seletor_periodicidade.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/seletor_periodicidade_personalizada.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

class TarefaPeriodicidade extends StatefulWidget {
  const TarefaPeriodicidade({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaPeriodicidade> createState() => _TarefaPeriodicidadeState();
}

class _TarefaPeriodicidadeState extends State<TarefaPeriodicidade> {
  final TarefasController controlador = TarefasController();

  Periodicidade periodicidadeSelecionada = .nenhuma;

  Future<void> selecionarPeriodicidade() async {
    final Periodicidade? periodicidadeEscolhida =
        await showModalBottomSheet<Periodicidade>(
          context: context,
          showDragHandle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          builder: (context) {
            return SeletorPeriodicidade(
              largura: widget.largura,
              periodicidadeInicial: periodicidadeSelecionada,
            );
          },
        );

    if (!mounted || periodicidadeEscolhida == null) return;

    if (periodicidadeEscolhida == .personalizada) {
      final ConfiguracaoPeriodicidade? configuracao =
          await showModalBottomSheet<ConfiguracaoPeriodicidade>(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) {
              return SeletorPeriodicidadePersonalizada(
                largura: widget.largura,
                configuracaoInicial:
                    controlador.configuracaoPeriodicidadePersonalizada,
              );
            },
          );

      if (!mounted || configuracao == null) return;

      setState(() {
        controlador.configuracaoPeriodicidadePersonalizada = configuracao;
        periodicidadeSelecionada = .personalizada;
      });

      return;
    }

    setState(() {
      periodicidadeSelecionada = periodicidadeEscolhida;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Row(
          children: [
            Icon(Icons.repeat_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Periodicidade',
              style: TextStyle(
                fontWeight: .w500,
                fontSize: widget.largura * 0.045,
              ),
            ),
          ],
        ),
        Spacer(),
        Flexible(
          flex: 15,
          child: OutlinedButton(
            onPressed: selecionarPeriodicidade,
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
              padding: WidgetStatePropertyAll(.all(widget.largura * 0.025)),
            ),
            child: Row(
              children: [
                Icon(
                  controlador.obterIconePeriodicidade(periodicidadeSelecionada),
                  size: widget.largura * 0.045,
                ),
                SizedBox(width: widget.largura * 0.015),
                Flexible(
                  child: Text(
                    controlador.formatarPeriodicidade(periodicidadeSelecionada),
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
