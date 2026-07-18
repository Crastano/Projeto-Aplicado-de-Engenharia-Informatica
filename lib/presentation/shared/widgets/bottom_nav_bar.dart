import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.indexAtual});

  final int indexAtual;

  void irPara(BuildContext context, int index) {
    if (index == indexAtual) return;

    const routes = ['/home', '/calendario', '/configuracoes'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indexAtual,
      onDestinationSelected: (index) => irPara(context, index),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.checklist), label: 'Tarefas'),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Calendário',
        ),
        NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Mais'),
      ],
    );
  }
}
