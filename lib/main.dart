import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Paginas
import 'package:pei/presentation/calendario/calendario.dart';
import 'package:pei/presentation/calendario/calendario_tres_dias.dart';
import 'package:pei/presentation/calendario/calendario_um_dia.dart';
import 'package:pei/presentation/categorias/categorias.dart';
import 'package:pei/presentation/configuracoes/configuracoes_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/conta_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/hora_dia_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/idioma_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/notificacoes_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/sobre_pagina.dart';
import 'package:pei/presentation/configuracoes/pages/tema_pagina.dart';
import 'package:pei/presentation/inicio/minhas_tarefas.dart';
import 'package:pei/presentation/auth/pagina_inicial.dart';
import 'package:pei/presentation/pesquisar/pesquisar.dart';
import 'package:pei/presentation/tarefas/criar_tarefa.dart';
import 'package:pei/presentation/tarefas/pagina_tarefa.dart';

// Temas
import 'package:pei/theme/tema_claro.dart';
import 'package:pei/theme/tema_escuro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

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
            '/calendarioTresDias': (context) => const CalendarioTresDias(),
            '/calendarioUmDia': (context) => const CalendarioUmDia(),
            '/criarTarefa': (context) => const CriarTarefa(),
            '/pesquisar': (context) => const PesquisarPage(),
            '/categorias': (context) => const CategoriasPage(),
            '/configuracoes': (context) => const MaisPage(),
            '/configuracoes/conta': (context) => const ContaPage(),
            '/configuracoes/notificacoes': (context) => NotificacoesPagina(),
            '/configuracoes/tema': (context) => TemaPagina(),
            '/configuracoes/hora-dia': (context) => HoraDiaPagina(),
            '/configuracoes/idioma': (context) => IdiomaPagina(),
            '/configuracoes/sobre': (context) => const SobrePagina(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/paginaTarefa') {
              final argumentos = settings.arguments;
              final tarefaId = switch (argumentos) {
                String id => id,
                TarefaModelo tarefa => tarefa.id,
                _ => null,
              };

              if (tarefaId != null) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => PaginaTarefa(tarefaId: tarefaId),
                );
              }
            }

            return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return const Scaffold(
                  body: Center(child: Text('Página não encontrada.')),
                );
              },
            );
          },
        );
      },
    );
  }
}
