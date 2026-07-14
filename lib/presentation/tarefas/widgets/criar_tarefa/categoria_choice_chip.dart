import 'package:flutter/material.dart';

class Categoria extends StatefulWidget {
  const Categoria({
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
  State<Categoria> createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.nome),
      selected: widget.selecionada,
      onSelected: (value) {
        if (value) {
          widget.onTap();
        }
      },
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      labelStyle: TextStyle(
        fontSize: widget.largura * 0.035,
        color: widget.selecionada ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
        fontWeight: .w500,
      ),
      side: BorderSide(
        color: widget.selecionada ? Colors.transparent : Theme.of(context).colorScheme.outline,
        width: widget.largura * 0.005,
      ),
      shape: const StadiumBorder(),
      padding: .all(widget.largura * 0.02),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
