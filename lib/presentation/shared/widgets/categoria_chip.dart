import 'package:flutter/material.dart';

class CategoriaChip extends StatelessWidget {
  const CategoriaChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.largura,
    required this.altura,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: .shrinkWrap,
      visualDensity: .compact,
      padding: .zero,
      label: Text(
        label,
        maxLines: 1,
        overflow: .ellipsis,
        style: TextStyle(
          color: textColor,
          fontWeight: .w500,
          fontSize: largura * 0.03,
        ),
      ),
      backgroundColor: backgroundColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        )
      )
    );
  }
}
