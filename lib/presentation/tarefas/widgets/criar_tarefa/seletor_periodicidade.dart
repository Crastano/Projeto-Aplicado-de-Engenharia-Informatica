import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Enums
import 'package:pei/enums/periodicidade.dart';

class SeletorPeriodicidade extends StatefulWidget {
  const SeletorPeriodicidade({
    super.key,
    required this.controlador,
    required this.largura,
    required this.periodicidadeInicial,
  });

  final TarefasControlador controlador;
  final double largura;
  final Periodicidade periodicidadeInicial;

  @override
  State<SeletorPeriodicidade> createState() => _SeletorPeriodicidadeState();
}

class _SeletorPeriodicidadeState extends State<SeletorPeriodicidade> {
  late Periodicidade periodicidadeSelecionada;

  @override
  void initState() {
    super.initState();
    periodicidadeSelecionada = widget.periodicidadeInicial;
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
                fontSize: widget.largura * 0.06,
                fontWeight: .w500,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Escolhe quando a tarefa deve repetir-se.',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Wrap(
              spacing: widget.largura * 0.035,
              runSpacing: widget.largura * 0.015,
              children: Periodicidade.values.map((periodicidade) {
                final selecionada = periodicidadeSelecionada == periodicidade;

                return ChoiceChip(
                  selected: selecionada,
                  showCheckmark: false,
                  avatar: Icon(
                    widget.controlador.obterIconePeriodicidade(periodicidade),
                    size: widget.largura * 0.045,
                    color: selecionada
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  label: Text(
                    periodicidade == .personalizada
                        ? 'Personalizada'
                        : widget.controlador.formatarPeriodicidade(
                            periodicidade,
                          ),
                  ),
                  labelStyle: TextStyle(
                    color: selecionada
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: .w500,
                  ),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  side: BorderSide(
                    color: selecionada
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: widget.largura * 0.005,
                  ),
                  shape: StadiumBorder(),
                  onSelected: (_) {
                    setState(() {
                      periodicidadeSelecionada = periodicidade;
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
                  Navigator.pop(context, periodicidadeSelecionada);
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
