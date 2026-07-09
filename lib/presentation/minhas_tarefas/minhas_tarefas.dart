import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// Controlador
import 'package:pei/controller/home_controller.dart';

// Widgets personais
import 'package:pei/presentation/minhas_tarefas/widgets/selecionar_data.dart';
import 'package:pei/presentation/minhas_tarefas/widgets/selecionar_filter.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';

import 'package:pei/tarefas.dart';

class MinhasTarefas extends StatefulWidget {
  const MinhasTarefas({super.key});

  @override
  State<MinhasTarefas> createState() => _MinhasTarefasState();
}

class _MinhasTarefasState extends State<MinhasTarefas> {
  final TarefasController controller = TarefasController();
  final List<TarefaItem> tarefas = Tarefas123().tarefas;

  void alterarEstadoTarefa(TarefaItem tarefa) {
    final indexOriginal = tarefas.indexOf(tarefa);

    if (indexOriginal == -1) return;

    setState(() {
      tarefas[indexOriginal] = tarefa.copyWith(
        isCompleted: !tarefa.isCompleted,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<TarefaItem> tarefasFiltradas = controller.filtrarTarefas(
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
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: largura * 0.1),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          currentIndex: 0,
          floatingActionButton: true,
          bottomNavigationBar: true,

          body: Padding(
            padding: .all(largura * 0.06),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    SelecionarData(
                      largura: largura,
                      selecionado: controller.dataSelecionada,
                      onChanged: (value) {
                        setState(() {
                          controller.dataSelecionada = value;
                        });
                      },
                    ),

                    SizedBox(height: altura * 0.02),

                    SelecionarFilter(
                      largura: largura,
                      selecionado: controller.filtroSelecionado,
                      onChanged: (value) {
                        setState(() {
                          controller.filtroSelecionado = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: altura * 0.06),

                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tarefasFiltradas.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: altura * 0.025);
                    },
                    itemBuilder: (context, index) {
                      return TarefaCard(
                        tarefa: tarefasFiltradas[index],
                        largura: largura,
                        altura: altura,
                        iconTap: () {
                          alterarEstadoTarefa(tarefasFiltradas[index]);
                        },
                        cardTap: () {},
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
