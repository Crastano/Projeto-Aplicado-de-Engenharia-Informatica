import 'package:flutter/material.dart';

import 'presentation/auth/pagina_inicial.dart';
import 'presentation/minhas_tarefas/minhas_tarefas.dart';

import 'theme/tema_claro.dart';
import 'theme/tema_escuro.dart';

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
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (_) => const PaginaInicial(),
        '/home': (_) => const MinhasTarefas(),
      },
    );
  }
}