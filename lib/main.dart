import 'package:flutter/material.dart';

import 'package:pei/models/eventoCalendario.dart';

// Páginas
import 'presentation/auth/pagina_inicial.dart';
import 'presentation/home/minhas_tarefas.dart';
import 'presentation/calendario/calendario.dart';
import 'package:pei/presentation/calendario/calendario_um_dia.dart';
import 'package:pei/presentation/calendario/calendario_tres_dias.dart';
import 'package:pei/presentation/tarefas/criar_tarefa.dart';

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
        '/calendarioTresDias': (_) => CalendarioTresDias(
          tarefas: [
            EventoCalendario(
              titulo: 'Cortar cabelo',
              inicio: DateTime(hoje.year, hoje.month, hoje.day, 10, 30),
              fim: DateTime(hoje.year, hoje.month, hoje.day, 11, 30),
            ),
            EventoCalendario(
              titulo: 'Tomar comprimido',
              inicio: DateTime(hoje.year, hoje.month, hoje.day + 1, 14, 15),
              fim: DateTime(hoje.year, hoje.month, hoje.day + 1, 14, 25),
              corFundo: const Color(0xFFDBEAFE),
              corTexto: const Color(0xFF1E40AF),
            ),
          ],
        ),
        '/calendarioUmDia': (_) => CalendarioUmDia(
          tarefas: [
            EventoCalendario(
              titulo: 'Cortar cabelo',
              inicio: DateTime(hoje.year, hoje.month, hoje.day, 10, 30),
              fim: DateTime(hoje.year, hoje.month, hoje.day, 11, 30),
            ),
            EventoCalendario(
              titulo: 'Tomar comprimido',
              inicio: DateTime(hoje.year, hoje.month, hoje.day + 1, 14, 15),
              fim: DateTime(hoje.year, hoje.month, hoje.day + 1, 14, 25),
              corFundo: const Color(0xFFDBEAFE),
              corTexto: const Color(0xFF1E40AF),
            ),
          ],
        ),
        '/criarTarefa': (_) => CriarTarefa(),
      },
    );
  }
}
