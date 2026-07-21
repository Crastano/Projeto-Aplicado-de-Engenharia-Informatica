import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controlador.dart';
import 'package:pei/controller/tarefas_estado.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'widgets/criar_tarefa/campo_titulo.dart';
import 'widgets/criar_tarefa/tarefa_data.dart';
import 'widgets/criar_tarefa/tarefa_data_limite.dart';
import 'widgets/criar_tarefa/tarefa_hora.dart';
import 'widgets/criar_tarefa/tarefa_periodicidade.dart';
import 'widgets/criar_tarefa/tarefa_selecionar_categoria.dart';
import 'widgets/criar_tarefa/tarefa_lembrete.dart';
import 'widgets/criar_tarefa/tarefa_notas.dart';
import 'widgets/criar_tarefa/tarefas_anexos.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({super.key, this.tarefa});

  final TarefaModelo? tarefa;

  @override
  State<CriarTarefa> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> {
  late final TarefasControlador controlador;
  final TarefasEstado tarefasEstado = TarefasEstado.instancia;
  bool aGuardar = false;

  @override
  void initState() {
    super.initState();
    controlador = TarefasControlador(tarefaInicial: widget.tarefa);
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  Future<void> guardarTarefa() async {
    if (aGuardar) return;

    FocusManager.instance.primaryFocus?.unfocus();

    final erro = controlador.validar();
    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    setState(() => aGuardar = true);

    try {
      final tarefa = controlador.construirTarefa();
      final guardada = controlador.editando
          ? await tarefasEstado.atualizar(tarefa)
          : await tarefasEstado.adicionar(tarefa);

      if (!mounted) return;

      if (!guardada) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível guardar a tarefa.')),
        );
        return;
      }

      Navigator.pop(context, tarefa);
    } catch (erro) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao guardar a tarefa: $erro')),
      );
    } finally {
      if (mounted) setState(() => aGuardar = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: controlador.editando ? 'Editar Tarefa' : 'Criar Tarefa',
          textSize: largura * 0.07,
          actions: [
            Padding(
              padding: .only(right: largura * 0.03),
              child: IconButton(
                tooltip: 'Guardar tarefa',
                onPressed: aGuardar ? null : guardarTarefa,
                icon: Icon(
                  Icons.check_rounded,
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
            padding: .all(largura * 0.06),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CampoTitulo(
                  controlador: controlador.tituloControlador,
                  largura: largura,
                  altura: altura,
                ),
                SizedBox(height: altura * 0.025),
                TarefaSelecionarCategoria(
                  controlador: controlador,
                  largura: largura,
                  altura: altura,
                ),
                SizedBox(height: altura * 0.025),
                Divider(),
                TarefaData(controlador: controlador, largura: largura),
                Divider(),
                TarefaDataLimite(controlador: controlador, largura: largura),
                Divider(),
                TarefaHora(controlador: controlador, largura: largura),
                Divider(),
                TarefaPeriodicidade(controlador: controlador, largura: largura),
                Divider(),
                TarefaLembrete(controlador: controlador, largura: largura),
                Divider(),
                TarefaNotas(controlador: controlador, largura: largura),
                Divider(),
                TarefaAnexos(controlador: controlador, largura: largura),
                SizedBox(height: altura * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
