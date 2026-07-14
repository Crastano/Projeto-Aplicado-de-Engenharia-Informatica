import 'package:flutter/material.dart';

class CampoTitulo extends StatelessWidget {
  const CampoTitulo({
    super.key,
    required this.controlador,
    required this.largura,
    required this.altura,
  });

  final TextEditingController controlador;
  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      textCapitalization: .sentences,
      style: TextStyle(
        fontSize: largura * 0.04,
      ),
      decoration: InputDecoration(
        hintText: 'Adicionar título',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: .all(largura * 0.035),
        border: OutlineInputBorder(
          borderRadius: .circular(
            largura * 0.025,
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: largura * 0.005,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(
            largura * 0.025,
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: largura * 0.005,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(
            largura * 0.025,
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: largura * 0.005,
          ),
        ),
      ),
    );
  }
}