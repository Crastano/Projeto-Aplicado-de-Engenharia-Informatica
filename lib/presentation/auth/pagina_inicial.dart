import 'package:flutter/material.dart';

// Widgets
import 'widgets/intro.dart';
import 'widgets/butao.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        return AppScaffold(
          title: '',
          textSize: 0,
          automaticallyImplyLeading: false,
          currentIndex: null,
          floatingActionButton: false,
          appBar: false,
          bottomNavigationBar: false,
          largura: largura,
          body: Padding(
            padding: .all(largura * 0.06),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: altura * 0.04),
                Intro(largura: largura, altura: altura),
                SizedBox(height: altura * 0.075),
                Butao(
                  largura: largura,
                  altura: altura,
                  texto: 'Entrar com Google',
                  icon: Icons.cloud_outlined,
                  onPressed: null,
                ),
                SizedBox(height: altura * 0.025),
                Butao(
                  largura: largura,
                  altura: altura,
                  texto: 'Continuar sem conta',
                  icon: Icons.login_rounded,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                SizedBox(height: altura * 0.01),
                Center(
                  child: Text(
                    'Podes ligar o Google Drive mais tarde nas configurações.',
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: largura * 0.035,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
