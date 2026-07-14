import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Controlador
import 'package:pei/controller/home_controller.dart';
import 'package:pei/presentation/home/widgets/selecionar_opcao.dart';

// Widgets
import 'widgets/selecionar_data.dart';
import 'widgets/selecionar_filter.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';

// Enums
import 'package:pei/enums/filter_data.dart';
import 'package:pei/enums/filter_tarefa.dart';

import 'package:pei/tarefas.dart';

class MinhasTarefas extends StatefulWidget {
  const MinhasTarefas({super.key, this.tarefas});

  final List<TarefaItem>? tarefas;

  @override
  State<MinhasTarefas> createState() => _MinhasTarefasState();
}

class _MinhasTarefasState extends State<MinhasTarefas> {
  final HomeControlador controlador = HomeControlador();
  late final List<TarefaItem> tarefas;

  @override
  void initState() {
    super.initState();

    tarefas = widget.tarefas ?? Tarefas123().tarefas;
  }

  void alterarEstadoTarefa(TarefaItem tarefa) {
    final indexOriginal = tarefas.indexOf(tarefa);

    if (indexOriginal == -1) return;

    setState(() {
      tarefas[indexOriginal] = tarefa.copyWith(
        estaCompletado: !tarefa.estaCompletado,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<TarefaItem> tarefasFiltradas = controlador.filtrarTarefas(
      tarefas,
    );

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

          body: Padding(
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

                SizedBox(height: altura * 0.06),

                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tarefasFiltradas.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: altura * 0.01);
                    },
                    itemBuilder: (context, index) {
                      return TarefaCard(
                        tarefa: tarefasFiltradas[index],
                        largura: largura,
                        altura: altura,
                        iconTap: () {
                          alterarEstadoTarefa(tarefasFiltradas[index]);
                        },
                        mostrarIcones: true,
                      );
                    },
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
