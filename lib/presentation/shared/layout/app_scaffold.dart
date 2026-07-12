import 'package:flutter/material.dart';
import 'package:pei/presentation/shared/widgets/bottom_nav_bar.dart';

class AppScaffold extends StatefulWidget {
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
    required this.largura,
  });

  final String title;
  final double textSize;
  final Widget body;
  final int? currentIndex;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool floatingActionButton;
  final bool bottomNavigationBar;
  final double largura;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: widget.textSize,
        ),
      ),
      actions: widget.actions,
      centerTitle: true,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      leading: widget.automaticallyImplyLeading
          ? Builder(
              builder: (context) {
                return IconButton(
                  tooltip: 'Voltar',
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left_outlined,
                    size: widget.largura * 0.075,
                  ),
                );
              },
            )
          : null,
    ),
    body: SafeArea(top: true, child: widget.body),
    bottomNavigationBar: widget.bottomNavigationBar
        ? BottomNavBar(indexAtual: widget.currentIndex ?? 0)
        : null,
    floatingActionButton: widget.floatingActionButton
        ? SizedBox(
            width: widget.largura * 0.15,
            height: widget.largura * 0.15,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/criarTarefa');
              },
              child: Icon(Icons.add_rounded, size: widget.largura * 0.1),
            ),
          )
        : null,
  );
}
