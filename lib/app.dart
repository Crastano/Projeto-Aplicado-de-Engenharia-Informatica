import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/pagina_inicial.dart';

class AppTarefas extends StatefulWidget {
  const AppTarefas({super.key});

  @override
  State<AppTarefas> createState() => _AppTarefasState();
}

class _AppTarefasState extends State<AppTarefas> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Tarefas",
      initialRoute: '/',
      routes: {
        '/': (_) => const PaginaInicial()
      },
      theme: ThemeData(
        useMaterial3: true,

        textTheme: GoogleFonts.interTextTheme()
      ),
    );
  }
}