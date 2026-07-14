import 'package:flutter/material.dart';

class SelecionarOpcao extends StatelessWidget {
  const SelecionarOpcao({
    super.key,
    required this.largura,
  });

  final double largura;

  void irPara(BuildContext context, String tipo) {
    final String rota;

    switch (tipo) {
      case 'pesquisar':
        rota = '/pesquisar';
        break;

      case 'categorias':
        rota = '/categorias';
        break;

      default:
        rota = '';
    }

    Navigator.pushNamed(context, rota);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Alterar visualização',
      icon: Icon(
        Icons.menu,
        size: largura * 0.075,
        color: Theme.of(context).iconTheme.color,
      ),
      onSelected: (tipo) {
        irPara(context, tipo);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'pesquisar', child: Row(
          children: [
            Icon(Icons.search_rounded),
            SizedBox(width: largura * 0.015,),
            Text('Pesquisar'),
          ],
        )),
        PopupMenuItem(value: 'categorias', child: Row(
          children: [
            Icon(Icons.category_outlined),
            SizedBox(width: largura * 0.015,),
            Text('Categorias'),
          ],
        )),
      ],
    );
  }
}
