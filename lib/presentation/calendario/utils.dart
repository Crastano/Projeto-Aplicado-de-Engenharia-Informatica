import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pei/models/tarefaItem.dart';

final kTarefas =
    LinkedHashMap<DateTime, List<TarefaItem>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll({
      DateTime(kToday.year, kToday.month, kToday.day): const [
        TarefaItem(
          titulo: 'Cortar cabelo',
          data: '10-07-2026 12:00',
          category: 'Evento',
          categoryBackground: Color(0xFFFEF3C7),
          categoryText: Color(0xFF92400E),
          hasNotification: true,
        ),
        TarefaItem(
          titulo: 'Pagar conta da luz',
          data: '10-07-2026 18:30',
          category: 'Pagar',
          categoryBackground: Color(0xFFFFDDF1),
          categoryText: Color(0xFFB83280),
        ),
        TarefaItem(
          titulo: 'Pagar conta da luz',
          data: '10-07-2026 18:30',
          category: 'Pagar',
          categoryBackground: Color(0xFFFFDDF1),
          categoryText: Color(0xFFB83280),
        ),
        TarefaItem(
          titulo: 'Pagar conta da luz',
          data: '10-07-2026 18:30',
          category: 'Pagar',
          categoryBackground: Color(0xFFFFDDF1),
          categoryText: Color(0xFFB83280),
        ),
      ],

      DateTime(kToday.year, kToday.month, kToday.day + 3): const [
        TarefaItem(
          titulo: 'Consulta médica',
          data: '13-07-2026 10:30',
          category: 'Evento',
          categoryBackground: Color(0xFFFEF3C7),
          categoryText: Color(0xFF92400E),
          hasNotification: true,
        ),
      ],

      DateTime(kToday.year, kToday.month, kToday.day + 8): const [
        TarefaItem(
          titulo: 'Entregar projeto',
          data: '18-07-2026 23:59',
          category: 'Trabalho',
          categoryBackground: Color(0xFFDCEBFF),
          categoryText: Color(0xFF0A56C2),
          hasNotification: true,
        ),
      ],
    });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year - 2, 1, 1);

final kLastDay = DateTime(kToday.year + 2, 12, 31);
