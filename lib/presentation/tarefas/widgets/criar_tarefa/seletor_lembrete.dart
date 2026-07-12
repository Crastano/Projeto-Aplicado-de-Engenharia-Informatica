import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

class SeletorLembrete extends StatefulWidget {
  const SeletorLembrete({
    super.key,
    required this.largura,
    required this.lembreteInicial,
  });

  final double largura;
  final Lembrete lembreteInicial;

  @override
  State<SeletorLembrete> createState() => _SeletorLembreteState();
}

class _SeletorLembreteState extends State<SeletorLembrete> {
  final TarefasController controlador = TarefasController();

  late Lembrete lembreteTemporario;

  @override
  void initState() {
    super.initState();
    lembreteTemporario = widget.lembreteInicial;
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
                fontSize: widget.largura * 0.055,
                fontWeight: .w600,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Escolhe quanto tempo antes queres receber o lembrete.',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                fontWeight: .w500,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Wrap(
              spacing: widget.largura * 0.035,
              runSpacing: widget.largura * 0.015,
              children: Lembrete.values.map((lembrete) {
                final selecionado = lembreteTemporario == lembrete;

                return ChoiceChip(
                  selected: selecionado,
                  showCheckmark: false,
                  avatar: Icon(
                    controlador.obterIconeLembrete(lembrete),
                    size: widget.largura * 0.045,
                    color: selecionado
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  label: lembrete == .personalizada
                      ? Text('Personalizada')
                      : Text(controlador.formatarLembrete(lembrete)),
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
                      lembreteTemporario = lembrete;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: widget.largura * 0.05),
            SizedBox(
              width: .infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context, lembreteTemporario);
                },
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
