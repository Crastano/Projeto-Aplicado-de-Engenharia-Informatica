import 'dart:async';
import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/calendario_controlador.dart';
import 'package:pei/controller/tarefas_estado.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'widgets/calendario_expansivel.dart';
import 'widgets/calendario_tres_dias/cabecalho.dart';
import 'widgets/calendario_tres_dias/timeline.dart';
import 'widgets/datas_limite_calendario.dart';
import 'widgets/selecionar_tipo_calendario.dart';
import 'widgets/sem_hora_calendario.dart';

class CalendarioTresDias extends StatefulWidget {
  const CalendarioTresDias({super.key});

  @override
  State<CalendarioTresDias> createState() => _CalendarioTresDiasState();
}

class _CalendarioTresDiasState extends State<CalendarioTresDias>
    with WidgetsBindingObserver {
  final CalendarioControlador controlador = CalendarioControlador();

  final TarefasEstado tarefasEstado = TarefasEstado.instancia;
  late DateTime diaInicial;

  Timer? temporizadorMeiaNoite;
  double deslocamentoHorizontal = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    tarefasEstado.addListener(_atualizarTarefas);
    diaInicial = controlador.normalizarData(DateTime.now());
    agendarMudancaDeDia();
  }

  @override
  void dispose() {
    temporizadorMeiaNoite?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    tarefasEstado.removeListener(_atualizarTarefas);
    super.dispose();
  }

  void _atualizarTarefas() {
    if (mounted) setState(() {});
  }

  void mudarDia(int quantidadeDias) {
    setState(() {
      diaInicial = diaInicial.add(Duration(days: quantidadeDias));
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
        diaInicial = controlador.normalizarData(DateTime.now());
      });

      agendarMudancaDeDia();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final hoje = controlador.normalizarData(DateTime.now());

    if (!controlador.mesmoDia(diaInicial, hoje)) {
      setState(() {
        diaInicial = hoje;
      });
    }

    agendarMudancaDeDia();
  }

  void selecionarData(DateTime data) {
    setState(() {
      diaInicial = controlador.normalizarData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;
        final tarefas = tarefasEstado.tarefas;
        final diasVisiveis = controlador.diasVisiveis(diaInicial);

        return AppScaffold(
          title: '3 Dias',
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
                paginaAtual: .tresDias,
                largura: largura,
              ),
            ),
          ],
          body: Padding(
            padding: EdgeInsets.all(largura * 0.06),
            child: Column(
              children: [
                SeletorCalendarioExpansivel(
                  dataSelecionada: diaInicial,
                  largura: largura,
                  altura: altura,
                  onDataSelecionada: selecionarData,
                ),
                SizedBox(height: largura * 0.025),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DatasLimiteCalendario(
                            dias: diasVisiveis,
                            tarefas: tarefas,
                            largura: largura,
                            altura: altura,
                          ),
                          TarefasSemHoraCalendario(
                            dias: diasVisiveis,
                            tarefas: tarefas,
                            largura: largura,
                          ),
                          CabecalhoTresDias(
                            dias: diasVisiveis,
                            largura: largura,
                            altura: altura,
                          ),
                          TimelineTresDia(
                            dias: diasVisiveis,
                            tarefas: tarefas,
                            alturaHora: altura * 0.075,
                            largura: largura,
                          ),
                          SizedBox(height: altura * 0.05),
                        ],
                      ),
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
