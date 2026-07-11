import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.indexAtual,
  });

  final int indexAtual;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void irPara(BuildContext context, int index) {
    final routes = ['/home', '/calendario', '/configuracoes'];
    if (index == widget.indexAtual) return;
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.indexAtual,
      onDestinationSelected: (index) => irPara(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.checklist),
          label: 'Tarefas',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Calendário',
        ),
        NavigationDestination(
          icon: Icon(Icons.more_horiz),
          label: 'Mais',
        ),
      ],
    );
  }
}
