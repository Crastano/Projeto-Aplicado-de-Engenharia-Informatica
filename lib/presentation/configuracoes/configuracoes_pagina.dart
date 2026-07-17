import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';

// Scaffold partilhado
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/linha_configuracao.dart';

class MaisPage extends StatefulWidget {
  const MaisPage({super.key});

  @override
  State<MaisPage> createState() => _MaisPageState();
}

class _MaisPageState extends State<MaisPage> {
  final ConfiguracoesControlador controlador = ConfiguracoesControlador.instancia;

  void abrirPagina(String rota) {
    Navigator.pushNamed(context, rota);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Configurações',
          textSize: largura * 0.07,
          automaticallyImplyLeading: false,
          currentIndex: 2,
          floatingActionButton: false,
          bottomNavigationBar: true,
          largura: largura,
          body: AnimatedBuilder(
            animation: controlador,
            builder: (context, child) {
              return SingleChildScrollView(
                padding: .all(largura * 0.04),
                child: Column(
                  children: [
                    LinhaConfiguracao(
                      icone: Icons.person_outline_rounded,
                      titulo: 'Conta',
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/conta');
                      },
                    ),
                    Divider(),
                    LinhaConfiguracao(
                      icone: Icons.notifications_none_rounded,
                      titulo: 'Notificações',
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/notificacoes');
                      },
                    ),
                    Divider(),
                    LinhaConfiguracao(
                      icone: Icons.color_lens_outlined,
                      titulo: 'Tema',
                      valor: controlador.nomeTema,
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/tema');
                      },
                    ),
                    Divider(),
                    LinhaConfiguracao(
                      icone: Icons.access_time_rounded,
                      titulo: 'Hora e dia',
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/hora-dia');
                      },
                    ),
                    Divider(),
                    LinhaConfiguracao(
                      icone: Icons.language_rounded,
                      titulo: 'Idioma',
                      bandeira: Text(
                        controlador.bandeiraIdioma,
                        style: TextStyle(fontSize: largura * 0.055),
                      ),
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/idioma');
                      },
                    ),
                    Divider(),
                    LinhaConfiguracao(
                      icone: Icons.people_outline_rounded,
                      titulo: 'Sobre',
                      largura: largura,
                      altura: altura,
                      onTap: () {
                        abrirPagina('/configuracoes/sobre');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
