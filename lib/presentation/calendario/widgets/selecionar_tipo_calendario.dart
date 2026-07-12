import 'package:flutter/material.dart';

enum CalendarioTipo { calendario, tresDias, hoje }

class SelecionarTipoCalendario extends StatefulWidget {
  const SelecionarTipoCalendario({
    super.key,
    required this.paginaAtual,
    required this.largura,
  });

  final CalendarioTipo paginaAtual;
  final double largura;

  @override
  State<SelecionarTipoCalendario> createState() =>
      _SelecionarTipoCalendarioState();
}

class _SelecionarTipoCalendarioState extends State<SelecionarTipoCalendario> {
  void irPara(BuildContext context, CalendarioTipo tipo) {
    if (tipo == widget.paginaAtual) return;

    final String rota;

    switch (tipo) {
      case .calendario:
        rota = '/calendario';
        break;

      case .tresDias:
        rota = '/calendarioTresDias';
        break;

      case .hoje:
        rota = '/calendarioUmDia';
        break;
    }

    Navigator.pushReplacementNamed(context, rota);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CalendarioTipo>(
      tooltip: 'Alterar visualização',
      initialValue: widget.paginaAtual,
      icon: Icon(Icons.menu_outlined, size: widget.largura * 0.09),
      onSelected: (tipo) {
        irPara(context, tipo);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: .calendario, child: Text('Calendário')),
        PopupMenuItem(value: .tresDias, child: Text('3 Dias')),
        PopupMenuItem(value: .hoje, child: Text('1 Dia')),
      ],
    );
  }
}
