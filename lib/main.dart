import 'package:flutter/material.dart';

import 'pages/pagina_inicial.dart';
import 'pages/home.dart';

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