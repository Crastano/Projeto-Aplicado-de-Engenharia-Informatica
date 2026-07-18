import 'package:flutter/material.dart';

class LinhaDetalhesTarefa extends StatelessWidget {
  const LinhaDetalhesTarefa({
    super.key,
    required this.icone,
    required this.titulo,
    required this.valor,
    required this.largura,
    required this.altura,
  });

  final IconData icone;
  final String titulo;
  final String valor;
  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: altura * 0.012),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: largura * 0.09,
            child: Icon(icone, size: largura * 0.075),
          ),

          SizedBox(width: largura * 0.035),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: largura * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: altura * 0.004),

                Text(
                  valor,
                  style: TextStyle(
                    fontSize: largura * 0.04,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
