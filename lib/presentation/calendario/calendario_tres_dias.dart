import 'package:flutter/material.dart';
import 'dart:async';

// Widgets pessonais
import 'package:pei/presentation/calendario/widgets/selecionar_tipo_calendario.dart';
import 'package:pei/presentation/calendario/widgets/calendario_tres_dias/cabecalho.dart';
import 'package:pei/presentation/calendario/widgets/calendario_tres_dias/timeline.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/calendario/widgets/calendario_expansivel.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

// Modelos
import 'package:pei/models/eventoCalendario.dart';

class CalendarioTresDias extends StatefulWidget {
  const CalendarioTresDias({super.key, this.tarefas = const []});

  final List<EventoCalendario> tarefas;

  @override
  State<CalendarioTresDias> createState() => _CalendarioTresDiasState();
}

class _CalendarioTresDiasState extends State<CalendarioTresDias>
    with WidgetsBindingObserver {
  final CalendarioController controlador =
      CalendarioController();

  late DateTime diaInicial;

  Timer? temporizadorMeiaNoite;

  double deslocamentoHorizontal = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    diaInicial = controlador.normalizarData(DateTime.now());

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
      diaInicial = diaInicial.add(Duration(days: quantidadeDias));
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
        diaInicial = controlador.normalizarData(DateTime.now());
      });

      agendarMudancaDeDia();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final hoje = controlador.normalizarData(DateTime.now());

      if (!controlador.mesmoDia(diaInicial, hoje)) {
        setState(() {
          diaInicial = hoje;
        });
      }

      agendarMudancaDeDia();
    }
  }

  void selecionarData(DateTime data) {
    setState(() {
      diaInicial = DateTime(data.year, data.month, data.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

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
            padding: .all(largura * 0.06),
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
                    behavior: .opaque,

                    onHorizontalDragStart: (_) {
                      deslocamentoHorizontal = 0;
                    },

                    onHorizontalDragUpdate: (detalhes) {
                      deslocamentoHorizontal += detalhes.delta.dx;
                    },

                    onHorizontalDragEnd: (_) {
                      terminarDeslize(largura);
                    },

                    onHorizontalDragCancel: () {
                      deslocamentoHorizontal = 0;
                    },

                    child: Column(
                      children: [
                        CabecalhoTresDias(
                          dias: diasVisiveis,
                          largura: largura,
                          altura: altura,
                        ),
                        Expanded(
                          child: TimelineTresDia(
                            dias: diasVisiveis,
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
