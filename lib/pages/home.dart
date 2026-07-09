import 'package:flutter/material.dart';
import 'package:pei/pages/shared/layout/app_scaffold.dart';

enum FilterData { ontem, hoje, amanha, mes }

class MinhasTarefas extends StatefulWidget {
  const MinhasTarefas({super.key});

  @override
  State<MinhasTarefas> createState() => _MinhasTarefasState();
}

class _MinhasTarefasState extends State<MinhasTarefas> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Minhas Tarefas',
          textSize: largura * 0.07,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: largura * 0.05),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: largura * 0.1),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          currentIndex: 0,
          floatingActionButton: true,
          bottomNavigationBar: true,

          body: Padding(
            padding: EdgeInsets.all(largura * 0.1),
            child: Column(
              children: [
                Column(
                  children: [
                    SelecionarData(largura: largura,),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SelecionarData extends StatefulWidget {
  const SelecionarData({super.key, required this.largura});

  final double largura;

  @override
  State<SelecionarData> createState() => _SelecionarDataState();
}

class _SelecionarDataState extends State<SelecionarData> {
  FilterData selecionado = FilterData.hoje;
  bool aberto = false;

  String get label {
    switch (selecionado) {
      case FilterData.ontem:
        return 'Ontem';
      case FilterData.hoje:
        return 'Hoje';
      case FilterData.amanha:
        return 'Amanhã';
      case FilterData.mes:
        return 'Mês atual';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double largura = widget.largura;

    return PopupMenuButton<FilterData>(
      onSelected: (value) => [
        setState(() {
          aberto = false;
          selecionado = value;
        }),
      ],
      itemBuilder: (context) => const [
        PopupMenuItem(value: FilterData.ontem, child: Text('Ontem')),
        PopupMenuItem(value: FilterData.hoje, child: Text('Hoje')),
        PopupMenuItem(value: FilterData.amanha, child: Text('Amanhã')),
        PopupMenuItem(value: FilterData.mes, child: Text('Mês atual')),
      ],
      onOpened: () => [
        setState(() {
          aberto = true;
        }),
      ],
      onCanceled: () => [
        setState(() {
          aberto = false;
        }),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: largura * 0.06,
            ),
          ),
          Icon(aberto ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: largura * 0.1),
        ],
      ),
    );
  }
}
