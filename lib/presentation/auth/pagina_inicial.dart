import 'package:flutter/material.dart';

// Widgets personais
import 'package:pei/presentation/auth/widgets/intro.dart';
import 'package:pei/presentation/auth/widgets/butao.dart';

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

        return Scaffold(
          body: SafeArea(
            top: true,
            child: Padding(
              padding: .all(largura * 0.1),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Spacer(),

                  Intro(largura: largura, altura: altura),

                  SizedBox(height: altura * 0.15),

                  Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Iniciar sessão',
                    icon: Icons.person_outline,
                    onPressed: () {},
                  ),

                  Spacer(),

                  Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Criar conta',
                    icon: Icons.person_add_alt_1_outlined,
                    onPressed: () {},
                  ),

                  Spacer(),

                  Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Entrar sem conta',
                    icon: Icons.login,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/home'),
                  ),

                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}