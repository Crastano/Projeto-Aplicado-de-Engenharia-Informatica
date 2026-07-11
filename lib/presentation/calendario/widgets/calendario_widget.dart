import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// Widgets personais
import 'calendario/dia_container.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

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
    required this.noDiaSelecionado,
    required this.headerVisibilidade,
    required this.marcaEvento,
  });

  final double largura;
  final double altura;
  final DateTime kFirstDay;
  final DateTime kLastDay;
  DateTime _focusedDay;
  final DateTime? _selectedDay;
  final Function(DateTime, DateTime) noDiaSelecionado;
  final bool headerVisibilidade;
  final bool marcaEvento;

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  final CalendarioController controlador = CalendarioController();

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
      eventLoader: controlador.obterTarefasDoDia,
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
      headerVisible: widget.headerVisibilidade,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        markersMaxCount: 1,
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: .all(color: Theme.of(context).colorScheme.primary),
        ),
        todayTextStyle: TextStyle(
          fontSize: widget.largura * 0.038,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      calendarBuilders: CalendarBuilders<TarefaItem>(
        headerTitleBuilder: (context, day) {
          return Text(
            controlador.mesTitulo(day),
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
        todayBuilder: (context, day, focusedDay) => DiaContainer(
          context: context,
          dia: day,
          largura: widget.largura,
          hoje: true,
        ),
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
          selecionado: true,
        ),
        markerBuilder: (context, day, events) {
          if (!widget.marcaEvento || events.isEmpty) {
            return const SizedBox.shrink();
          }

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
