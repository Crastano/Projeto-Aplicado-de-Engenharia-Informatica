import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

//Controladores
import 'package:pei/controller/calendario_controlador.dart';
import 'package:pei/controller/configuracoes_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Widgets
import 'calendario/dia_container.dart';

class CalendarioWidget extends StatelessWidget {
  CalendarioWidget({
    super.key,
    required this.largura,
    required this.altura,
    required this.primeiroDia,
    required this.ultimoDia,
    required this.focusedDay,
    required this.selectedDay,
    required this.noDiaSelecionado,
    required this.headerVisibilidade,
    required this.marcaTarefa,
    this.tarefas = const [],
    this.onPageChanged,
  });

  final double largura;
  final double altura;
  final DateTime primeiroDia;
  final DateTime ultimoDia;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime) noDiaSelecionado;
  final bool headerVisibilidade;
  final bool marcaTarefa;
  final List<TarefaModelo> tarefas;
  final ValueChanged<DateTime>? onPageChanged;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    return TableCalendar<TarefaModelo>(
      firstDay: primeiroDia,
      lastDay: ultimoDia,
      focusedDay: focusedDay,
      calendarFormat: .month,
      availableCalendarFormats: const {.month: 'Mês'},
      startingDayOfWeek:
          ConfiguracoesControlador.instancia.primeiroDiaSemana == 'Domingo'
          ? .sunday
          : .monday,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      eventLoader: (day) {
        return controlador.tarefasIndicadasNoDia(day, tarefas);
      },
      onDaySelected: noDiaSelecionado,
      onPageChanged: onPageChanged,
      rowHeight: largura * 0.13,
      daysOfWeekHeight: altura * 0.03,
      headerVisible: headerVisibilidade,
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left, size: largura * 0.1),
        rightChevronIcon: Icon(Icons.chevron_right, size: largura * 0.1),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        markersMaxCount: 1,
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          shape: .circle,
          border: .all(color: Theme.of(context).colorScheme.primary),
        ),
        todayTextStyle: TextStyle(
          fontSize: largura * 0.038,
          fontWeight: .w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      calendarBuilders: CalendarBuilders<TarefaModelo>(
        headerTitleBuilder: (context, day) {
          return Text(
            controlador.formatarData(day, false, false, true),
            textAlign: .center,
            style: TextStyle(fontSize: largura * 0.06, fontWeight: .w500),
          );
        },
        dowBuilder: (context, dia) {
          return Center(
            child: Text(
              controlador.formatarData(dia, false, true, false),
              style: TextStyle(fontSize: largura * 0.04, fontWeight: .w500),
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return DiaContainer(dia: day, largura: largura);
        },
        todayBuilder: (context, day, focusedDay) {
          return DiaContainer(dia: day, largura: largura, hoje: true);
        },
        outsideBuilder: (context, day, focusedDay) {
          return DiaContainer(dia: day, largura: largura, outside: true);
        },
        selectedBuilder: (context, day, focusedDay) {
          return DiaContainer(dia: day, largura: largura, selecionado: true);
        },
        markerBuilder: (context, day, events) {
          if (!marcaTarefa || events.isEmpty) {
            return const SizedBox.shrink();
          }

          return Positioned(
            bottom: largura * 0.004,
            child: Container(
              width: largura * 0.012,
              height: largura * 0.012,
              decoration: BoxDecoration(
                shape: .circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
