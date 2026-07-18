import 'package:flutter/material.dart';

class CategoriaChoiceChip extends StatelessWidget {
  const CategoriaChoiceChip({
    super.key,
    required this.largura,
    required this.selecionada,
    required this.onTap,
    required this.nome,
  });

  final double largura;
  final bool selecionada;
  final VoidCallback onTap;
  final String nome;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(nome),
      selected: selecionada,
      onSelected: (value) {
        if (value) onTap();
      },
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      labelStyle: TextStyle(
        fontSize: largura * 0.035,
        color: selecionada
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
        fontWeight: .w500,
      ),
      side: BorderSide(
        color: selecionada
            ? Colors.transparent
            : Theme.of(context).colorScheme.outline,
        width: largura * 0.005,
      ),
      shape: StadiumBorder(),
      padding: .all(largura * 0.02),
      materialTapTargetSize: .shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
