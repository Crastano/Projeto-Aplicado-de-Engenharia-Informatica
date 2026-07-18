import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Controladores
import 'package:pei/controller/tarefas_estado.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'widgets/calendario/calendario_lista_tarefas.dart';
import 'widgets/calendario_widget.dart';
import 'widgets/selecionar_tipo_calendario.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  final TarefasEstado tarefasEstado = TarefasEstado.instancia;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  void noDiaSelecionado(DateTime novoDia, DateTime novoDiaFocado) {
    if (isSameDay(selectedDay, novoDia)) return;

    setState(() {
      selectedDay = novoDia;
      focusedDay = novoDiaFocado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Calendário',
          textSize: largura * 0.07,
          automaticallyImplyLeading: false,
          currentIndex: 1,
          floatingActionButton: true,
          bottomNavigationBar: true,
          largura: largura,
          actions: [
            Padding(
              padding: .only(right: largura * 0.05),
              child: SelecionarTipoCalendario(
                paginaAtual: .calendario,
                largura: largura,
              ),
            ),
          ],
          body: AnimatedBuilder(
            animation: tarefasEstado,
            builder: (context, _) {
              final tarefas = tarefasEstado.tarefas;
              final diaAtual = selectedDay ?? focusedDay;

              return SingleChildScrollView(
                padding: .all(largura * 0.06),
                child: Column(
                  children: [
                    CalendarioWidget(
                      largura: largura,
                      altura: altura,
                      primeiroDia: DateTime(2000),
                      ultimoDia: DateTime(2100),
                      focusedDay: focusedDay,
                      selectedDay: selectedDay,
                      noDiaSelecionado: noDiaSelecionado,
                      headerVisibilidade: true,
                      marcaTarefa: true,
                      tarefas: tarefas,
                      onPageChanged: (novoDiaFocado) {
                        setState(() {
                          focusedDay = novoDiaFocado;
                        });
                      },
                    ),
                    SizedBox(height: altura * 0.03),
                    CalendarioListaTarefas(
                      tarefas: tarefas,
                      dia: diaAtual,
                      largura: largura,
                      altura: altura,
                    ),
                    SizedBox(height: altura * 0.05),
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
