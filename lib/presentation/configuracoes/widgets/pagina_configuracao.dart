import 'package:flutter/material.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

class PaginaConfiguracao extends StatelessWidget {
  const PaginaConfiguracao({
    super.key,
    required this.titulo,
    required this.children,
  });

  final String titulo;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;

        return AppScaffold(
          title: titulo,
          textSize: largura * 0.07,
          automaticallyImplyLeading: true,
          currentIndex: null,
          floatingActionButton: false,
          bottomNavigationBar: false,
          largura: largura,
          actions: [],

          body: ListView(
            padding: .all(largura * 0.06),
            children: children,
          ),
        );
      },
    );
  }
}