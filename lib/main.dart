import 'package:flutter/material.dart';

// Base de dados
import 'package:pei/data/database/base_de_dados.dart';

// Controladores
import 'package:pei/controller/categorias_controlador.dart';
import 'package:pei/controller/configuracoes_controlador.dart';
import 'package:pei/controller/tarefas_estado.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await AppDatabase.instancia.database;
    await CategoriasControlador.instancia.inicializar();
    await ConfiguracoesControlador.instancia.inicializar();
    await TarefasEstado.instancia.inicializar();
    runApp(MyApp());
  } catch (erro) {
    runApp(AppErroInicializacao(erro: erro));
  }
}

class AppErroInicializacao extends StatelessWidget {
  const AppErroInicializacao({super.key, required this.erro});

  final Object erro;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double largura = constraints.maxWidth;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: .all(largura * 0.06),
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Icon(Icons.storage_rounded, size: largura * 0.075),
                      SizedBox(height: largura * 0.1),
                      Text(
                        'Não foi possível abrir a base de dados local.',
                        textAlign: .center,
                        style: TextStyle(fontSize: largura * 0.1, fontWeight: .w600),
                      ),
                      SizedBox(height: largura * 0.01),
                      Text('$erro', textAlign: .center),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
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
