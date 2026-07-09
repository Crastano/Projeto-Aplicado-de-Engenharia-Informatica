import 'package:flutter/material.dart';

class CategoriaChip extends StatefulWidget {
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
  State<CategoriaChip> createState() => _CategoriaChipState();
}

class _CategoriaChipState extends State<CategoriaChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        widget.label,
        style: TextStyle(
          color: widget.textColor,
          fontWeight: .w500,
          fontSize: widget.largura * 0.035,
        ),
      ),
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: widget.backgroundColor),
        borderRadius: .circular(widget.largura * 0.05),
      ),
    );
  }
}
