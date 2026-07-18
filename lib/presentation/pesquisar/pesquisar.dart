import 'package:flutter/material.dart';

import 'package:pei/controller/categorias_controlador.dart';
import 'package:pei/controller/pesquisar_controlador.dart';
import 'package:pei/controller/tarefas_estado.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';

class PesquisarPage extends StatefulWidget {
  const PesquisarPage({super.key});

  @override
  State<PesquisarPage> createState() => _PesquisarPageState();
}

class _PesquisarPageState extends State<PesquisarPage> {
  late final PesquisarControlador controlador;
  final CategoriasControlador categoriasControlador =
      CategoriasControlador.instancia;
  final TarefasEstado tarefasEstado = TarefasEstado.instancia;

  @override
  void initState() {
    super.initState();
    controlador = PesquisarControlador(tarefasEstado: tarefasEstado);
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Pesquisar',
          textSize: largura * 0.07,
          automaticallyImplyLeading: true,
          currentIndex: null,
          floatingActionButton: false,
          bottomNavigationBar: false,
          largura: largura,
          body: Padding(
            padding: .all(largura * 0.06),
            child: Column(
              children: [
                ListenableBuilder(
                  listenable: controlador,
                  builder: (context, _) {
                    return TextField(
                      controller: controlador.pesquisaControlador,
                      textInputAction: .search,
                      style: TextStyle(fontSize: largura * 0.04),
                      decoration: InputDecoration(
                        hintText: 'Pesquisar tarefas',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: largura * 0.075,
                        ),
                        suffixIcon:
                            controlador.pesquisaControlador.text.isNotEmpty
                            ? IconButton(
                                tooltip: 'Limpar pesquisa',
                                onPressed: controlador.limparPesquisa,
                                icon: const Icon(Icons.close_rounded),
                              )
                            : null,
                        filled: true,
                        contentPadding: .all(largura * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: .circular(largura * 0.025),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: largura * 0.005,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: .circular(largura * 0.025),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: largura * 0.005,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: .circular(largura * 0.025),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: largura * 0.005,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: altura * 0.02),
                AnimatedBuilder(
                  animation: categoriasControlador,
                  builder: (context, _) {
                    return ListenableBuilder(
                      listenable: controlador,
                      builder: (context, _) {
                        return SizedBox(
                          width: .infinity,
                          child: SingleChildScrollView(
                            scrollDirection: .horizontal,
                            child: Row(
                              children: [
                                ChoiceChip(
                                  label: Text('Todas'),
                                  avatar: Icon(
                                    Icons.category_outlined,
                                    size: largura * 0.045,
                                    color:
                                        controlador.categoriaIdSelecionada ==
                                            null
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                  ),
                                  selected:
                                      controlador.categoriaIdSelecionada ==
                                      null,
                                  showCheckmark: false,
                                  onSelected: (_) {
                                    controlador.selecionarCategoria(null);
                                  },
                                  side: BorderSide(
                                    color:
                                        controlador.categoriaIdSelecionada ==
                                            null
                                        ? Colors.transparent
                                        : Theme.of(context).colorScheme.outline,
                                    width: largura * 0.005,
                                  ),
                                ),
                                SizedBox(width: largura * 0.025),
                                ...categoriasControlador.categorias.map((
                                  categoria,
                                ) {
                                  final selecionada =
                                      controlador.categoriaIdSelecionada ==
                                      categoria.id;

                                  return Padding(
                                    padding: .only(right: largura * 0.025),
                                    child: ChoiceChip(
                                      label: Text(categoria.nome),
                                      avatar: Icon(
                                        Icons.label_outline_rounded,
                                        color: selecionada
                                            ? categoria.cor.texto(context)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                      ),
                                      selected: selecionada,
                                      showCheckmark: false,
                                      selectedColor: categoria.cor.fundo(
                                        context,
                                      ),
                                      labelStyle: TextStyle(
                                        fontSize: largura * 0.035,
                                        fontWeight: .w500,
                                        color: selecionada
                                            ? categoria.cor.texto(context)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                      ),
                                      onSelected: (_) {
                                        controlador.selecionarCategoria(
                                          categoria.id,
                                        );
                                      },
                                      side: BorderSide(
                                        color: selecionada
                                            ? categoria.cor.texto(context)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.outline,
                                        width: largura * 0.005,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: altura * 0.03),
                Expanded(
                  child: ListenableBuilder(
                    listenable: controlador,
                    builder: (context, _) {
                      final tarefas = controlador.tarefasFiltradas;

                      if (tarefas.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: .min,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: largura * 0.2,
                              ),
                              SizedBox(height: altura * 0.02),
                              Text(
                                'Nenhuma tarefa encontrada',
                                textAlign: .center,
                                style: TextStyle(
                                  fontSize: largura * 0.045,
                                  fontWeight: .w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: .only(bottom: altura * 0.1),
                        itemCount: tarefas.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: altura * 0.015);
                        },
                        itemBuilder: (context, index) {
                          final tarefa = tarefas[index];

                          return TarefaCard(
                            tarefa: tarefa,
                            largura: largura,
                            altura: altura,
                            iconTap: () {
                              tarefasEstado.alternarConclusao(tarefa.id);
                            },
                            mostrarIcones: true,
                          );
                        },
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
