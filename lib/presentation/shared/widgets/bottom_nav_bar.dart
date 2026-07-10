import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  void _goTo(BuildContext context, int index) {
    final routes = ['/home', '/calendario', '/configuracoes'];
    if (index == currentIndex) return;
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _goTo(context, index),
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
