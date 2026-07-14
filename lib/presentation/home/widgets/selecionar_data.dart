import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/home_controller.dart';

// Enums
import 'package:pei/enums/filter_data.dart';

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
  final HomeControlador controlador = HomeControlador();

  bool aberto = false;

  @override
  Widget build(BuildContext context) {
    final double largura = widget.largura;

    return PopupMenuButton<FilterData>(
      tooltip: 'Filtrar tempo',
      initialValue: widget.selecionado,
      onSelected: (value) {
        setState(() {
          aberto = false;
        });

        widget.onChanged(value);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: .nenhuma, child: Row(
          children: [
            Icon(Icons.block_outlined),
            SizedBox(width: widget.largura * 0.01,),
            Text('Nenhuma', style: TextStyle(fontWeight: .w400),),
          ],
        )),
        PopupMenuItem(value: .ontem, child: Row(
          children: [
            Icon(Icons.history_rounded),
            SizedBox(width: widget.largura * 0.01,),
            Text('Ontem', style: TextStyle(fontWeight: .w400),),
          ],
        )),
        PopupMenuItem(value: .hoje, child: Row(
          children: [
            Icon(Icons.today_outlined),
            SizedBox(width: widget.largura * 0.01,),
            Text('Hoje', style: TextStyle(fontWeight: .w400),),
          ],
        )),
        PopupMenuItem(value: .amanha, child: Row(
          children: [
            Icon(Icons.event_outlined),
            SizedBox(width: widget.largura * 0.01,),
            Text('Amanhã', style: TextStyle(fontWeight: .w400),),
          ],
        )),
        PopupMenuItem(value: .mes, child: Row(
          children: [
            Icon(Icons.calendar_month_outlined),
            SizedBox(width: widget.largura * 0.01,),
            Text('Mês atual', style: TextStyle(fontWeight: .w400),),
          ],
        )),
        PopupMenuItem(value: .ano, child: Row(
          children: [
            Icon(Icons.date_range_outlined),
            SizedBox(width: widget.largura * 0.01,),
            Text('Ano atual', style: TextStyle(fontWeight: .w400),),
          ],
        )),
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
        mainAxisSize: .min,
        children: [
          Text(
            controlador.dataLabel(widget.selecionado),
            style: TextStyle(fontWeight: .w500, fontSize: largura * 0.06),
          ),
          AnimatedRotation(
            turns: aberto ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: widget.largura * 0.075,
            ),
          ),
        ],
      ),
    );
  }
}
