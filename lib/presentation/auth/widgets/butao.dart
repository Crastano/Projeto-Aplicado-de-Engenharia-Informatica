import 'package:flutter/material.dart';

class Butao extends StatefulWidget {
  const Butao({
    super.key,
    required this.largura,
    required this.altura,
    required this.texto,
    required this.icon,
    required this.onPressed,
  });

  final double largura;
  final double altura;
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<Butao> createState() => _ButaoState();
}

class _ButaoState extends State<Butao> {
  @override
  Widget build(BuildContext context) {
    final double alturaButao = widget.altura * 0.1;

    return SizedBox(
      width: .infinity,
      height: alturaButao,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Expanded(flex: 3, child: Icon(widget.icon, size: alturaButao * 0.5)),
            Expanded(
              flex: 7,
              child: Text(
                widget.texto,
                maxLines: 1,
                style: TextStyle(fontSize: alturaButao * 0.23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
