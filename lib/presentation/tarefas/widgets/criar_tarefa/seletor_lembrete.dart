import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Enums
import 'package:pei/enums/lembrete.dart';

class SeletorLembrete extends StatefulWidget {
  const SeletorLembrete({
    super.key,
    required this.controlador,
    required this.largura,
    required this.lembreteInicial,
  });

  final TarefasControlador controlador;
  final double largura;
  final Lembrete lembreteInicial;

  @override
  State<SeletorLembrete> createState() => _SeletorLembreteState();
}

class _SeletorLembreteState extends State<SeletorLembrete> {
  late Lembrete lembreteSelecionado;

  @override
  void initState() {
    super.initState();
    lembreteSelecionado = widget.lembreteInicial;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: .all(widget.largura * 0.06),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              'Lembrete',
              style: TextStyle(
                fontSize: widget.largura * 0.06,
                fontWeight: .w500,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Escolhe quanto tempo antes queres receber o lembrete.',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: widget.largura * 0.025,
                  runSpacing: widget.largura * 0.015,
                  children: Lembrete.values.map((lembrete) {
                    final selecionado = lembreteSelecionado == lembrete;

                    return ChoiceChip(
                      selected: selecionado,
                      showCheckmark: false,
                      avatar: Icon(
                        widget.controlador.obterIconeLembrete(lembrete),
                        size: widget.largura * 0.045,
                        color: selecionado
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      label: Text(
                        lembrete == .personalizada
                            ? 'Personalizado'
                            : widget.controlador.formatarLembrete(lembrete),
                      ),
                      labelStyle: TextStyle(
                        color: selecionado
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: .w500,
                      ),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      side: BorderSide(
                        color: selecionado
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: widget.largura * 0.005,
                      ),
                      shape: StadiumBorder(),
                      onSelected: (_) {
                        setState(() {
                          lembreteSelecionado = lembrete;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: widget.largura * 0.04),
            SizedBox(
              width: .infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, lembreteSelecionado),
                child: Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
