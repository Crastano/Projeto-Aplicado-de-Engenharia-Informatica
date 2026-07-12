import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

class SeletorPeriodicidade extends StatefulWidget {
  const SeletorPeriodicidade({
    super.key,
    required this.largura,
    required this.periodicidadeInicial,
  });

  final double largura;
  final Periodicidade periodicidadeInicial;

  @override
  State<SeletorPeriodicidade> createState() => _SeletorPeriodicidadeState();
}

class _SeletorPeriodicidadeState extends State<SeletorPeriodicidade> {
  final TarefasController controlador = TarefasController();

  late Periodicidade periodicidadeSelecionado;

  @override
  void initState() {
    super.initState();

    periodicidadeSelecionado = widget.periodicidadeInicial;
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
              'Periodicidade',
              style: TextStyle(
                fontSize: widget.largura * 0.055,
                fontWeight: .w600,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Escolhe quando a tarefa deve repetir-se.',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                fontWeight: .w500,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Wrap(
              spacing: widget.largura * 0.035,
              runSpacing: widget.largura * 0.015,
              children: Periodicidade.values.map((periodicidade) {
                final selecionado = periodicidadeSelecionado == periodicidade;

                return ChoiceChip(
                  selected: selecionado,
                  showCheckmark: false,
                  avatar: Icon(
                    controlador.obterIconePeriodicidade(periodicidade),
                    size: widget.largura * 0.045,
                    color: selecionado
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  label: periodicidade == .personalizada
                      ? Text('Personalizada')
                      : Text(controlador.formatarPeriodicidade(periodicidade)),
                  labelStyle: TextStyle(
                    color: selecionado
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: .w500,
                  ),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surface,
                  side: BorderSide(
                    color: selecionado
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: widget.largura * 0.005,
                  ),
                  shape: StadiumBorder(),
                  onSelected: (_) {
                    setState(() {
                      periodicidadeSelecionado = periodicidade;
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
                  Navigator.pop(context, periodicidadeSelecionado);
                },
                child: Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
