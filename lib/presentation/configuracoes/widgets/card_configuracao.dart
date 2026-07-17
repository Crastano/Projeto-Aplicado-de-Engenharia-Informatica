import 'package:flutter/material.dart';

class CardConfiguracao extends StatelessWidget {
  const CardConfiguracao({super.key, required this.children, required this.largura});

  final List<Widget> children;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(largura * 0.05),
        side: BorderSide(color: Theme.of(context).colorScheme.outline, width: largura * 0.005),
      ),
      child: Column(children: children),
    );
  }
}