import 'package:flutter/material.dart';
import 'package:pei/controller/home_controller.dart';

class SelecionarData extends StatefulWidget {
  const SelecionarData({
    super.key,
    required this.largura,
    required this.selecionado,
    required this.onChanged,
  });

  final double largura;
  final FilterData selecionado;
  final ValueChanged<FilterData> onChanged;

  @override
  State<SelecionarData> createState() => _SelecionarDataState();
}

class _SelecionarDataState extends State<SelecionarData> {
  bool aberto = false;

  String get label {
    switch (widget.selecionado) {
      case .nenhuma:
        return 'Nenhuma';
      case .ontem:
        return 'Ontem';
      case .hoje:
        return 'Hoje';
      case .amanha:
        return 'Amanhã';
      case .mes:
        return 'Mês atual';
      case .ano:
        return 'Ano atual';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double largura = widget.largura;

    return PopupMenuButton<FilterData>(
      initialValue: widget.selecionado,
      onSelected: (value) {
        setState(() {
          aberto = false;
        });

        widget.onChanged(value);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: .nenhuma, child: Text('Nenhuma')),
        PopupMenuItem(value: .ontem, child: Text('Ontem')),
        PopupMenuItem(value: .hoje, child: Text('Hoje')),
        PopupMenuItem(value: .amanha, child: Text('Amanhã')),
        PopupMenuItem(value: .mes, child: Text('Mês atual')),
        PopupMenuItem(value: .ano, child: Text('Ano atual')),
      ],
      onOpened: () {
        setState(() {
          aberto = true;
        });
      },
      onCanceled: () {
        setState(() {
          aberto = false;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: .w500, fontSize: largura * 0.06),
          ),
          Icon(
            aberto
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: largura * 0.1,
          ),
        ],
      ),
    );
  }
}