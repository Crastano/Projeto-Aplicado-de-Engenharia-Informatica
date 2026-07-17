import 'dart:async';
import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';
import 'package:pei/tarefas.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'widgets/calendario_expansivel.dart';
import 'widgets/calendario_um_dia/cabecalho.dart';
import 'widgets/calendario_um_dia/timeline.dart';
import 'widgets/datas_limite_calendario.dart';
import 'widgets/selecionar_tipo_calendario.dart';

class CalendarioUmDia extends StatefulWidget {
  const CalendarioUmDia({super.key, this.tarefas});

  final List<TarefaItem>? tarefas;

  @override
  State<CalendarioUmDia> createState() => _CalendarioUmDiaState();
}

class _CalendarioUmDiaState extends State<CalendarioUmDia>
    with WidgetsBindingObserver {
  final CalendarioControlador controlador = CalendarioControlador();

  late final List<TarefaItem> tarefas;
  late DateTime diaVisivel;

  Timer? temporizadorMeiaNoite;

  double deslocamentoHorizontal = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    tarefas = widget.tarefas ?? Tarefas123().tarefas;
    diaVisivel = controlador.normalizarData(DateTime.now());
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

    mudarDia(deslocamentoHorizontal < 0 ? 1 : -1);
    deslocamentoHorizontal = 0;
  }

  void agendarMudancaDeDia() {
    temporizadorMeiaNoite?.cancel();

    final agora = DateTime.now();
    final proximaMeiaNoite = DateTime(agora.year, agora.month, agora.day + 1);

    temporizadorMeiaNoite = Timer(proximaMeiaNoite.difference(agora), () {
      if (!mounted) return;

      setState(() {
        diaVisivel = controlador.normalizarData(DateTime.now());
      });

      agendarMudancaDeDia();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final hoje = controlador.normalizarData(DateTime.now());

    if (!controlador.mesmoDia(diaVisivel, hoje)) {
      setState(() {
        diaVisivel = hoje;
      });
    }

    agendarMudancaDeDia();
  }

  void selecionarData(DateTime data) {
    setState(() {
      diaVisivel = controlador.normalizarData(data);
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
              padding: EdgeInsets.only(right: largura * 0.05),
              child: SelecionarTipoCalendario(
                paginaAtual: .umDia,
                largura: largura,
              ),
            ),
          ],
          body: Padding(
            padding: EdgeInsets.all(largura * 0.06),
            child: Column(
              children: [
                SeletorCalendarioExpansivel(
                  dataSelecionada: diaVisivel,
                  largura: largura,
                  altura: altura,
                  onDataSelecionada: selecionarData,
                ),
                SizedBox(height: largura * 0.02),
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
                        DatasLimiteCalendario(
                          dias: [diaVisivel],
                          tarefas: tarefas,
                          largura: largura,
                          altura: altura,
                        ),
                        CabecalhoUmDia(
                          dia: diaVisivel,
                          largura: largura,
                          altura: altura,
                        ),
                        Expanded(
                          child: TimelineUmDia(
                            dia: diaVisivel,
                            tarefas: tarefas,
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
