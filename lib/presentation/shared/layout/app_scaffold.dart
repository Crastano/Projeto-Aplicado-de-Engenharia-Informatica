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
    this.appBar = true,
    required this.automaticallyImplyLeading,
    required this.floatingActionButton,
    required this.bottomNavigationBar,
    required this.largura,
  });

  final String title;
  final double textSize;
  final Widget body;
  final int? currentIndex;
  final List<Widget>? actions;
  final bool appBar;
  final bool automaticallyImplyLeading;
  final bool floatingActionButton;
  final bool bottomNavigationBar;
  final double largura;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar
        ? AppBar(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: textSize),
            ),
            actions: actions,
            centerTitle: true,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: automaticallyImplyLeading
                ? IconButton(
                    tooltip: 'Voltar',
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left_outlined,
                      size: largura * 0.075,
                    ),
                  )
                : null,
          )
        : null,
    body: SafeArea(top: true, child: body),
    bottomNavigationBar: bottomNavigationBar
        ? BottomNavBar(indexAtual: currentIndex ?? 0)
        : null,
    floatingActionButton: floatingActionButton
        ? SizedBox(
            width: largura * 0.15,
            height: largura * 0.15,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/criarTarefa');
              },
              child: Icon(Icons.add_rounded, size: largura * 0.1),
            ),
          )
        : null,
  );
}
