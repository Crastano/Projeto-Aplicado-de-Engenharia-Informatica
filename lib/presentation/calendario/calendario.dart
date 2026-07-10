import 'package:flutter/material.dart';
import 'package:pei/presentation/calendario/widgets/calendario_lista_tarefas.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';
import 'package:pei/tarefas.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// Widget persoais
import 'widgets/calendario_widget.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  late final ValueNotifier<List<TarefaItem>> tarefasSelecionados;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    tarefasSelecionados = ValueNotifier(obterTarefasDoDia(_selectedDay!));
  }

  @override
  void dispose() {
    tarefasSelecionados.dispose();
    super.dispose();
  }

  List<TarefaItem> obterTarefasDoDia(DateTime day) {
    return kTarefas[day] ?? [];
  }

  void noDiaSelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (isSameDay(_selectedDay, selectedDay)) {
      return;
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    tarefasSelecionados.value = obterTarefasDoDia(selectedDay);
  }

  String mesTitulo(DateTime dia) {
    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${meses[dia.month - 1]} ${dia.year}';
  }

  String formatarDataSelecionada(DateTime dia) {
    const diasSemana = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo',
    ];

    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${diasSemana[dia.weekday - 1]}, ${dia.day} de ${meses[dia.month - 1]}';
  }

  final List<TarefaItem> tarefas = Tarefas123().tarefas;

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
          actions: [
            Padding(
              padding: .only(right: largura * 0.05),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu_outlined, size: largura * 0.09),
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
                    obterTarefasDoDia: obterTarefasDoDia,
                    noDiaSelecionado: noDiaSelecionado,
                    mesTitulo: mesTitulo,
                  ),

                  SizedBox(height: altura * 0.03),

                  CalendarioListaTarefas(
                    tarefasSelecionados: tarefasSelecionados,
                    largura: largura,
                    altura: altura,
                    formatarDataSelecionada: formatarDataSelecionada,
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