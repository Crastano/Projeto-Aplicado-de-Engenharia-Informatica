import 'package:flutter/material.dart';

class LinhaConfiguracao extends StatelessWidget {
  const LinhaConfiguracao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.largura,
    required this.altura,
    required this.onTap,
    this.valor,
    this.bandeira,
  });

  final IconData icone;
  final String titulo;
  final String? valor;
  final Widget? bandeira;

  final double largura;
  final double altura;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: .all(largura * 0.025),
            child: Row(
              children: [
                Icon(icone, size: largura * 0.075),
                SizedBox(width: largura * 0.025),
                Expanded(
                  child: Text(
                    titulo,
                    style: TextStyle(fontSize: largura * 0.05),
                  ),
                ),

                if (bandeira != null)
                  bandeira!
                else if (valor != null)
                  Text(
                    valor!,
                    style: TextStyle(
                      fontSize: largura * 0.045,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                SizedBox(width: largura * 0.015),
                Icon(
                  Icons.chevron_right_rounded,
                  size: largura * 0.075,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
