import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/inicio_controlador.dart';
import 'package:pei/controller/tarefas_estado.dart';

// Enums
import 'package:pei/enums/filter_data.dart';
import 'package:pei/enums/filter_tarefa.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';
import 'widgets/selecionar_data.dart';
import 'widgets/selecionar_filter.dart';
import 'widgets/selecionar_opcao.dart';

class MinhasTarefas extends StatefulWidget {
  const MinhasTarefas({super.key});

  @override
  State<MinhasTarefas> createState() => _MinhasTarefasState();
}

class _MinhasTarefasState extends State<MinhasTarefas> {
  final InicioControlador controlador = InicioControlador();
  final TarefasEstado tarefasEstado = TarefasEstado.instancia;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Minhas Tarefas',
          textSize: largura * 0.07,
          actions: [
            Padding(
              padding: .only(right: largura * 0.05),
              child: SelecionarOpcao(largura: largura),
            ),
          ],
          automaticallyImplyLeading: false,
          currentIndex: 0,
          floatingActionButton: true,
          bottomNavigationBar: true,
          largura: largura,
          body: AnimatedBuilder(
            animation: tarefasEstado,
            builder: (context, _) {
              final tarefasFiltradas = controlador.filtrarTarefas(
                tarefasEstado.tarefas,
              );

              return Padding(
                padding: .all(largura * 0.06),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SelecionarData(
                      largura: largura,
                      selecionado: controlador.dataSelecionada,
                      onChanged: (FilterData value) {
                        setState(() {
                          controlador.dataSelecionada = value;
                        });
                      },
                    ),
                    SizedBox(height: altura * 0.02),
                    Center(
                      child: SelecionarFilter(
                        largura: largura,
                        selecionado: controlador.filtroSelecionado,
                        onChanged: (FilterTarefa value) {
                          setState(() {
                            controlador.filtroSelecionado = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: altura * 0.04),
                    Expanded(
                      child: tarefasFiltradas.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: .min,
                                children: [
                                  Icon(
                                    Icons.task_alt_rounded,
                                    size: largura * 0.18,
                                  ),
                                  SizedBox(height: largura * 0.04),
                                  Text(
                                    controlador.textoVazio(
                                      controlador.filtroSelecionado,
                                    ),
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: largura * 0.045,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              padding: .only(bottom: altura * 0.1),
                              itemCount: tarefasFiltradas.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: altura * 0.015);
                              },
                              itemBuilder: (context, index) {
                                final tarefa = tarefasFiltradas[index];

                                return TarefaCard(
                                  tarefa: tarefa,
                                  largura: largura,
                                  altura: altura,
                                  iconTap: () async {
                                    await tarefasEstado.alternarConclusao(tarefa.id);
                                  },
                                  mostrarIcones: true,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
