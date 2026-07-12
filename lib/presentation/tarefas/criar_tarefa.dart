import 'package:flutter/material.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

// Widgets personais
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/campo_titulo.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_data.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_hora.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_periodicidade.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_selecionar_categoria.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_lembrete.dart';
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/tarefa_notas.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({super.key});

  @override
  State<CriarTarefa> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> {
  final TarefasController controlador = TarefasController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Criar Tarefa',
          textSize: largura * 0.07,
          actions: [
            Padding(
              padding: .only(right: largura * 0.05),
              child: IconButton(
                tooltip: 'Guardar tarefa',
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  size: largura * 0.075,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
          automaticallyImplyLeading: true,
          currentIndex: null,
          floatingActionButton: false,
          bottomNavigationBar: false,
          largura: largura,

          body: SingleChildScrollView(
            keyboardDismissBehavior: .onDrag,
            child: Padding(
              padding: .all(largura * 0.06),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CampoTitulo(
                    controlador: controlador.tituloController,
                    largura: largura,
                    altura: altura,
                  ),

                  SizedBox(height: altura * 0.025),

                  TarefaSelecionarCategoria(largura: largura, altura: altura),

                  SizedBox(height: altura * 0.025),

                  Divider(),

                  SizedBox(height: altura * 0.005),

                  TarefaData(largura: largura),

                  SizedBox(height: altura * 0.005),

                  Divider(),

                  SizedBox(height: altura * 0.005),

                  TarefaHora(largura: largura),

                  SizedBox(height: altura * 0.005),

                  Divider(),

                  SizedBox(height: altura * 0.005),

                  TarefaPeriodicidade(largura: largura),

                  SizedBox(height: altura * 0.005),

                  Divider(),

                  SizedBox(height: altura * 0.005),

                  TarefaLembrete(largura: largura),

                  SizedBox(height: altura * 0.005),

                  Divider(),

                  SizedBox(height: altura * 0.005),

                  TarefaNotas(largura: largura),

                  SizedBox(height: altura * 0.005),

                  Divider(),

                  SizedBox(height: altura * 0.005),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
