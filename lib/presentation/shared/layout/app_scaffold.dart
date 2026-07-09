import 'package:flutter/material.dart';
import 'package:pei/presentation/shared/widgets/bottom_nav_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.textSize,
    required this.body,
    required this.currentIndex,
    this.actions,
    required this.automaticallyImplyLeading,
    required this.floatingActionButton,
    required this.bottomNavigationBar,
  });

  final String title;
  final double textSize;
  final Widget body;
  final int? currentIndex;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool floatingActionButton;
  final bool bottomNavigationBar;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: textSize),
      ),
      actions: actions,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
    ),
    body: SafeArea(child: body),
    bottomNavigationBar: bottomNavigationBar
        ? BottomNavBar(currentIndex: currentIndex ?? 0)
        : null,
    floatingActionButton: floatingActionButton
        ? FloatingActionButton(
            onPressed: () {},
            shape: CircleBorder(),
            child: const Icon(Icons.add),
          )
        : null,
  );
}
