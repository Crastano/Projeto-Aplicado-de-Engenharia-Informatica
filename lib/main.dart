import 'package:flutter/material.dart';
import 'package:pei/models/tarefa_item.dart';
import 'package:pei/tarefas.dart';

// Páginas
import 'presentation/auth/pagina_inicial.dart';
import 'presentation/home/minhas_tarefas.dart';
import 'presentation/calendario/calendario.dart';
import 'presentation/calendario/calendario_um_dia.dart';
import 'presentation/calendario/calendario_tres_dias.dart';
import 'presentation/tarefas/criar_tarefa.dart';
import 'presentation/tarefas/pagina_tarefa.dart';
import 'package:pei/presentation/pesquisar/pesquisar.dart';

// Temas
import 'theme/tema_claro.dart';
import 'theme/tema_escuro.dart';

final hoje = DateTime.now();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Tarefas',
      theme: temaClaro(),
      darkTheme: temaEscuro(),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (_) => const PaginaInicial(),
        '/home': (_) => const MinhasTarefas(),
        '/calendario': (_) => const Calendario(),
        '/calendarioTresDias': (_) => CalendarioTresDias(),
        '/calendarioUmDia': (_) => CalendarioUmDia(),
        '/criarTarefa': (_) => CriarTarefa(),
        '/pesquisar': (_) => PesquisarPage(tarefas: Tarefas123().tarefas,),
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
  }
}
