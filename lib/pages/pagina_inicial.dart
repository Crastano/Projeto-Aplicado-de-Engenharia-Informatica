import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    Size ecra = MediaQuery.sizeOf(context);
    double largura = ecra.width;
    double altura = ecra.height;
    double escala = (largura * 0.5) + (altura * 0.5);

    double espaco = altura * 0.03;
    double padding = escala * 0.05;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(flex: 1),

              TopoInicial(),

              Spacer(flex: 2),

              Column(
                children: [
                  BotaoInicial(
                    texto: 'Iniciar sessão',
                    icon: Icons.person_outline,
                    principal: true,
                    onTap: () {},
                  ),

                  SizedBox(height: espaco),

                  BotaoInicial(
                    texto: 'Criar conta',
                    icon: Icons.person_add_alt_1_outlined,
                    principal: false,
                    onTap: () {},
                  ),

                  SizedBox(height: espaco),

                  BotaoInicial(
                    texto: 'Entrar sem conta',
                    icon: Icons.login_outlined,
                    principal: false,
                    onTap: () {},
                  ),
                ],
              ),

              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class TopoInicial extends StatelessWidget {
  const TopoInicial({super.key});

  @override
  Widget build(BuildContext context) {
    Size ecra = MediaQuery.sizeOf(context);
    double largura = ecra.width;

    double tamanhoTitulo = largura * 0.1;
    double tamanhoTexto = largura * 0.05;
    double espacoEntreTituloTexto = largura * 0.05;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá!',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanhoTitulo,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),

              SizedBox(height: espacoEntreTituloTexto),

              Text(
                'Ao criar conta, podes usar a cloud para sincronizar as tuas tarefas online.',
                style: TextStyle(
                  fontSize: tamanhoTexto,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 4,
          child: ClipRRect(
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}

class BotaoInicial extends StatelessWidget {
  final String texto;
  final IconData icon;
  final bool principal;
  final VoidCallback onTap;

  const BotaoInicial({
    super.key,
    required this.texto,
    required this.icon,
    required this.principal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size ecra = MediaQuery.sizeOf(context);
    double altura = ecra.height;

    final Color corFundo = principal ? Color(0xFF0A66E7) : Color(0xFFE8EAEE);
    final Color corTexto = principal ? Colors.white : Color(0xFF111827);
    final Color corIcone = principal ? Colors.white : Color(0xFF1E1E1E);
    final Color corSombra = principal ? Color(0x800A66E7) : Color(0x80000000);
    final Border? border = principal
        ? null
        : Border.all(color: Color(0xFFD6DAE0), width: 2);

    double alturaBotao = altura * 0.1;
    double tamanhoIcone = alturaBotao * 0.5;
    double tamanhoTexto = alturaBotao * 0.25;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: alturaBotao,
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(15),
          border: border,
          boxShadow: [
            BoxShadow(color: corSombra, offset: Offset(2, 2), blurRadius: 1),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Icon(icon, size: tamanhoIcone, color: corIcone),
            ),

            Expanded(
              flex: 7,
              child: Text(
                texto,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: TextStyle(
                  fontSize: tamanhoTexto,
                  fontWeight: FontWeight.w500,
                  color: corTexto,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
