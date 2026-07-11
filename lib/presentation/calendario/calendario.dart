import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';
import 'package:pei/tarefas.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// Widget personais
import 'widgets/calendario_widget.dart';
import 'package:pei/presentation/calendario/widgets/calendario/calendario_lista_tarefas.dart';
import 'package:pei/presentation/calendario/widgets/selecionar_tipo_calendario.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

import 'package:pei/controller/calendario_controller.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  final CalendarioController controlador = CalendarioController();
  late final ValueNotifier<List<TarefaItem>> tarefasSelecionados;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    tarefasSelecionados = ValueNotifier(
      controlador.obterTarefasDoDia(_selectedDay!),
    );
  }

  @override
  void dispose() {
    tarefasSelecionados.dispose();
    super.dispose();
  }

  void noDiaSelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (isSameDay(_selectedDay, selectedDay)) {
      return;
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    tarefasSelecionados.value = controlador.obterTarefasDoDia(selectedDay);
  }

  final List<TarefaItem> tarefas = Tarefas123().tarefas;

  final CalendarioTipo selecionado = CalendarioTipo.calendario;

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

          body: Padding(
            padding: .all(largura * 0.06),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CalendarioWidget(
                    largura: largura,
                    altura: altura,
                    kFirstDay: kFirstDay,
                    kLastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    noDiaSelecionado: noDiaSelecionado,
                    headerVisibilidade: true,
                    marcaEvento: true,
                  ),

                  SizedBox(height: altura * 0.03),

                  CalendarioListaTarefas(
                    tarefasSelecionados: tarefasSelecionados,
                    largura: largura,
                    altura: altura,
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                  ),

                  SizedBox(height: altura * 0.05),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
