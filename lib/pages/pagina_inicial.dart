import 'package:flutter/material.dart';

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
              padding: EdgeInsets.all(largura * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),

                  _Intro(largura: largura, altura: altura),

                  SizedBox(height: altura * 0.15),

                  _Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Iniciar sessão',
                    icon: Icons.person_outline,
                    onPressed: () {},
                  ),

                  Spacer(),

                  _Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Criar conta',
                    icon: Icons.person_add_alt_1_outlined,
                    onPressed: () {},
                  ),

                  Spacer(),

                  _Butao(
                    largura: largura,
                    altura: altura,
                    texto: 'Entrar sem conta',
                    icon: Icons.login,
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
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

class _Intro extends StatelessWidget {
  const _Intro({required this.largura, required this.altura});

  final double largura;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá!',
                style: TextStyle(
                  fontSize: largura * 0.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: altura * 0.025),
              Text(
                'Ao criar conta, podes usar a cloud para sincronizar as tuas tarefas online.',
                style: TextStyle(fontSize: largura * 0.05, height: 1.2),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
      ],
    );
  }
}

class _Butao extends StatelessWidget {
  const _Butao({
    required this.largura,
    required this.altura,
    required this.texto,
    required this.icon,
    required this.onPressed,
  });

  final double largura;
  final double altura;
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final double alturaButao = altura * 0.1;

    return SizedBox(
      width: double.infinity,
      height: alturaButao,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(flex: 3, child: Icon(icon, size: alturaButao * 0.5)),
            Expanded(
              flex: 7,
              child: Text(
                texto,
                maxLines: 1,
                style: TextStyle(fontSize: alturaButao * 0.23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
