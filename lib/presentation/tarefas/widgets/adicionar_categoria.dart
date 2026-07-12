import 'package:flutter/material.dart';

class AdicionarCategoria extends StatefulWidget {
  const AdicionarCategoria({
    required this.largura,
    required this.altura,
    required this.onTap,
  });

  final double largura;
  final double altura;

  final VoidCallback onTap;

  @override
  State<AdicionarCategoria> createState() => _AdicionarCategoriaState();
}

class _AdicionarCategoriaState extends State<AdicionarCategoria> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(
        Icons.add,
        size: widget.largura * 0.045,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        'Adicionar categoria',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      side: BorderSide.none,
      shape: const StadiumBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: widget.onTap,
    );
  }
}
