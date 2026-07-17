import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/configuracoes_controlador.dart';

import 'package:pei/models/tarefa_item.dart';
import 'package:pei/presentation/categorias/categorias.dart';
import 'package:pei/tarefas.dart';

// Páginas
import 'presentation/inicio/pagina_inicial.dart';
import 'presentation/home/minhas_tarefas.dart';
import 'presentation/calendario/calendario.dart';
import 'presentation/calendario/calendario_um_dia.dart';
import 'presentation/calendario/calendario_tres_dias.dart';
import 'presentation/tarefas/criar_tarefa.dart';
import 'presentation/tarefas/pagina_tarefa.dart';
import 'package:pei/presentation/pesquisar/pesquisar.dart';
import 'package:pei/presentation/configuracoes/configuracoes_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/conta_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/notificacoes_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/tema_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/hora_dia_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/idioma_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/sobre_pagina.dart';

// Temas
import 'theme/tema_claro.dart';
import 'theme/tema_escuro.dart';

final hoje = DateTime.now();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ConfiguracoesControlador controlador = ConfiguracoesControlador.instancia;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controlador,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App de Tarefas',
          theme: temaClaro(),
          darkTheme: temaEscuro(),
          themeMode: controlador.tema,
          initialRoute: '/',
          routes: {
            '/': (context) => const PaginaInicial(),
            '/home': (context) => const MinhasTarefas(),
            '/calendario': (context) => const Calendario(),
            '/calendarioTresDias': (context) => CalendarioTresDias(),
            '/calendarioUmDia': (context) => CalendarioUmDia(),
            '/criarTarefa': (context) => CriarTarefa(),
            '/pesquisar': (context) =>
                PesquisarPage(tarefas: Tarefas123().tarefas),
            '/categorias': (context) => CategoriasPage(),
            '/configuracoes': (context) => MaisPage(),
            '/configuracoes/conta': (context) => ContaPage(),
            '/configuracoes/notificacoes': (context) => NotificacoesPage(),
            '/configuracoes/tema': (context) => TemaPage(),
            '/configuracoes/hora-dia': (context) => HoraDiaPage(),
            '/configuracoes/idioma': (context) => IdiomaPage(),
            '/configuracoes/sobre': (context) => SobrePage(),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/paginaTarefa':
                final argumentos = settings.arguments;

                if (argumentos is! TarefaItem) {
                  return MaterialPageRoute(
                    builder: (context) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Não foi possível carrefar a tarefa.'),
                        ),
                      );
                    },
                  );
                }

                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) {
                    return PaginaTarefa(tarefa: argumentos);
                  },
                );

              default:
                return MaterialPageRoute(
                  builder: (context) {
                    return const Scaffold(
                      body: Center(child: Text('Página não encontrada.')),
                    );
                  },
                );
            }
          },
        );
      },
    );
  }
}
