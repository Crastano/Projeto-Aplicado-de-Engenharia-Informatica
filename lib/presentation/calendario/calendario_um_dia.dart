import 'package:flutter/material.dart';
import 'dart:async';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

// Widgets do calendário
import 'package:pei/presentation/calendario/widgets/calendario_um_dia/cabecalho.dart';
import 'package:pei/presentation/calendario/widgets/calendario_um_dia/timeline.dart';
import 'package:pei/presentation/calendario/widgets/selecionar_tipo_calendario.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/calendario/widgets/calendario_expansivel.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class CalendarioUmDia extends StatefulWidget {
  const CalendarioUmDia({super.key, this.tarefas = const []});

  final List<EventoCalendario> tarefas;

  @override
  State<CalendarioUmDia> createState() => _CalendarioUmDiaState();
}

class _CalendarioUmDiaState extends State<CalendarioUmDia>
    with WidgetsBindingObserver {
  final CalendarioController controlador = CalendarioController();

  late DateTime diaVisivel;

  Timer? temporizadorMeiaNoite;

  double deslocamentoHorizontal = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final agora = DateTime.now();

    diaVisivel = DateTime(agora.year, agora.month, agora.day);

    agendarMudancaDeDia();
  }

  @override
  void dispose() {
    temporizadorMeiaNoite?.cancel();

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void mudarDia(int quantidadeDias) {
    setState(() {
      diaVisivel = diaVisivel.add(Duration(days: quantidadeDias));
    });
  }

  void terminarDeslize(double largura) {
    final distanciaMinima = largura * 0.10;

    if (deslocamentoHorizontal.abs() < distanciaMinima) {
      deslocamentoHorizontal = 0;
      return;
    }

    if (deslocamentoHorizontal < 0) {
      mudarDia(1);
    } else {
      mudarDia(-1);
    }

    deslocamentoHorizontal = 0;
  }

  void agendarMudancaDeDia() {
    temporizadorMeiaNoite?.cancel();

    final agora = DateTime.now();

    final proximaMeiaNoite = DateTime(agora.year, agora.month, agora.day + 1);

    final tempoRestante = proximaMeiaNoite.difference(agora);

    temporizadorMeiaNoite = Timer(tempoRestante, () {
      if (!mounted) {
        return;
      }

      setState(() {
        diaVisivel = controlador.normalizarData(DateTime.now());
      });

      agendarMudancaDeDia();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final hoje = controlador.normalizarData(DateTime.now());

      if (!controlador.mesmoDia(diaVisivel, hoje)) {
        setState(() {
          diaVisivel = hoje;
        });
      }

      agendarMudancaDeDia();
    }
  }

  void selecionarData(DateTime data) {
    setState(() {
      diaVisivel = DateTime(data.year, data.month, data.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: '1 Dia',
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
                paginaAtual: .hoje,
                largura: largura,
              ),
            ),
          ],
          body: Padding(
  padding: EdgeInsets.all(
    largura * 0.06,
  ),
  child: Column(
    children: [
      SeletorCalendarioExpansivel(
        dataSelecionada: diaVisivel,
        largura: largura,
        altura: altura,
        onDataSelecionada: selecionarData,
      ),

      SizedBox(
        height: largura * 0.02,
      ),

      Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,

          onHorizontalDragStart: (_) {
            deslocamentoHorizontal = 0;
          },

          onHorizontalDragUpdate: (details) {
            deslocamentoHorizontal += details.delta.dx;
          },

          onHorizontalDragEnd: (_) {
            terminarDeslize(largura);
          },

          onHorizontalDragCancel: () {
            deslocamentoHorizontal = 0;
          },

          child: Column(
            children: [
              CabecalhoUmDia(
                dia: diaVisivel,
                largura: largura,
                altura: altura,
              ),
              Expanded(
                child: TimelineUmDia(
                  dia: diaVisivel,
                  tarefas: widget.tarefas,
                  alturaHora: altura * 0.075,
                  largura: largura,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),
        );
      },
    );
  }
}
