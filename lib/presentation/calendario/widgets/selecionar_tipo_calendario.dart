import 'package:flutter/material.dart';

// Enums
import 'package:pei/enums/calendario_tipo.dart';

class SelecionarTipoCalendario extends StatelessWidget {
  const SelecionarTipoCalendario({
    super.key,
    required this.paginaAtual,
    required this.largura,
  });

  final CalendarioTipo paginaAtual;
  final double largura;

  void irPara(BuildContext context, CalendarioTipo tipo) {
    if (tipo == paginaAtual) return;

    final String rota;

    switch (tipo) {
      case .calendario:
        rota = '/calendario';
        break;

      case .tresDias:
        rota = '/calendarioTresDias';
        break;

      case .umDia:
        rota = '/calendarioUmDia';
        break;
    }

    Navigator.pushReplacementNamed(context, rota);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CalendarioTipo>(
      tooltip: 'Alterar visualização',
      initialValue: paginaAtual,
      icon: Icon(
        Icons.menu,
        size: largura * 0.075,
        color: Theme.of(context).iconTheme.color,
      ),
      onSelected: (tipo) {
        irPara(context, tipo);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: .calendario, child: Row(
          children: [
            Icon(Icons.calendar_today_outlined),
            SizedBox(width: largura * 0.015,),
            Text('Calendário'),
          ],
        )),
        PopupMenuItem(value: .tresDias, child: Row(
          children: [
            Icon(Icons.view_week_outlined),
            SizedBox(width: largura * 0.015,),
            Text('3 Dias'),
          ],
        )),
        PopupMenuItem(value: .umDia, child: Row(
          children: [
            Icon(Icons.view_day_outlined),
            SizedBox(width: largura * 0.015,),
            Text('1 Dia'),
          ],
        )),
      ],
    );
  }
}
