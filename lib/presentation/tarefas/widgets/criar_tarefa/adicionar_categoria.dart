import 'package:flutter/material.dart';

class AdicionarCategoria extends StatelessWidget {
  const AdicionarCategoria({
    super.key,
    required this.largura,
    required this.altura,
    required this.onTap,
  });

  final double largura;
  final double altura;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(
        Icons.add,
        size: largura * 0.045,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        'Adicionar categoria',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      side: .none,
      shape: StadiumBorder(),
      materialTapTargetSize: .shrinkWrap,
      onPressed: onTap,
    );
  }
}
