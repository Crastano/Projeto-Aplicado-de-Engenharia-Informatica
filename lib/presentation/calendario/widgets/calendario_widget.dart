import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

import 'dia_container.dart';

// ignore: must_be_immutable
class CalendarioWidget extends StatefulWidget {
  CalendarioWidget({
    super.key,
    required this.largura,
    required this.altura,
    required this.kFirstDay,
    required this.kLastDay,
    required this._focusedDay,
    required this._selectedDay,
    required this.obterTarefasDoDia,
    required this.noDiaSelecionado,
    required this.mesTitulo,
  });

  final double largura;
  final double altura;
  final DateTime kFirstDay;
  final DateTime kLastDay;
  DateTime _focusedDay;
  final DateTime? _selectedDay;
  final List<TarefaItem> Function(DateTime)? obterTarefasDoDia;
  final Function(DateTime, DateTime) noDiaSelecionado;
  final Function(DateTime) mesTitulo;

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar<TarefaItem>(
      firstDay: widget.kFirstDay,
      lastDay: widget.kLastDay,
      focusedDay: widget._focusedDay,
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(widget._selectedDay, day),
      eventLoader: widget.obterTarefasDoDia,
      onDaySelected: widget.noDiaSelecionado,
      onPageChanged: (focusedDay) {
        setState(() => widget._focusedDay = focusedDay);
      },
      rowHeight: widget.largura * 0.13,
      daysOfWeekHeight: widget.altura * 0.03,
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left, size: widget.largura * 0.1),
        rightChevronIcon: Icon(Icons.chevron_right, size: widget.largura * 0.1),
      ),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: true,
        markersMaxCount: 1,
      ),
      calendarBuilders: CalendarBuilders<TarefaItem>(
        headerTitleBuilder: (context, day) {
          return Text(
            widget.mesTitulo(day),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.largura * 0.06,
              fontWeight: FontWeight.w500,
            ),
          );
        },
        dowBuilder: (context, dia) {
          const diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];

          return Center(
            child: Text(
              diasSemana[dia.weekday - 1],
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) =>
            DiaContainer(context: context, dia: day, largura: widget.largura),
        todayBuilder: (context, day, focusedDay) =>
            DiaContainer(context: context, dia: day, largura: widget.largura),
        outsideBuilder: (context, day, focusedDay) => DiaContainer(
          context: context,
          dia: day,
          largura: widget.largura,
          outside: true,
        ),
        selectedBuilder: (context, day, focusedDay) => DiaContainer(
          context: context,
          dia: day,
          largura: widget.largura,
          selected: true,
        ),
        markerBuilder: (context, day, events) {
          if (events.isEmpty) return const SizedBox.shrink();

          return Positioned(
            bottom: widget.largura * 0.004,
            child: Container(
              width: widget.largura * 0.012,
              height: widget.largura * 0.012,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
