import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiaContainer extends StatefulWidget {
  DiaContainer({
    super.key,
    required this.context,
    required this.dia,
    required this.largura,
    this.selected,
    this.outside,
  });

  final BuildContext context;
  final DateTime dia;
  final double largura;
  bool? selected;
  bool? outside;

  @override
  State<DiaContainer> createState() => _DiaContainerState();
}

class _DiaContainerState extends State<DiaContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.largura * 0.09,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.selected ?? false
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
        child: Text(
          '${widget.dia.day}',
          style: TextStyle(
            fontSize: widget.largura * 0.045,
            fontWeight: .w500,
            color: widget.selected ?? false
                ? Theme.of(context).colorScheme.onPrimary
                : widget.outside ?? false
                ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
