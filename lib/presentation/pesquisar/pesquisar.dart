import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/pesquisar_controlador.dart';
import 'package:pei/controller/categorias_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Widgets
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';

class PesquisarPage extends StatefulWidget {
  const PesquisarPage({super.key, this.tarefas = const []});

  final List<TarefaItem> tarefas;

  @override
  State<PesquisarPage> createState() => _PesquisarPageState();
}

class _PesquisarPageState extends State<PesquisarPage> {
  late final PesquisarController controlador;
  late final CategoriasController categoriasControlador;

  @override
  void initState() {
    super.initState();

    controlador = PesquisarController(tarefas: widget.tarefas);
    categoriasControlador = CategoriasController();
  }

  @override
  void didUpdateWidget(covariant PesquisarPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tarefas != widget.tarefas) {
      controlador.atualizarTarefas(widget.tarefas);
    }
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
          actions: [],
          
          body: Padding(
            padding: .all(largura * 0.06),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: controlador,
                  builder: (context, child) {
                    return TextField(
                      controller: controlador.pesquisaController,
                      textInputAction: .search,
                      style: TextStyle(fontSize: largura * 0.04),
                      decoration: InputDecoration(
                        hintText: 'Pesquisar tarefas',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: largura * 0.075,
                        ),
                        suffixIcon:
                            controlador.pesquisaController.text.isNotEmpty
                            ? IconButton(
                                tooltip: 'Limpar pesquisa',
                                onPressed: controlador.limparPesquisa,
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: largura * 0.06,
                                ),
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

                SizedBox(height: altura * 0.018),

                AnimatedBuilder(
                  animation: controlador,
                  builder: (context, child) {
                    return AnimatedBuilder(
                      animation: categoriasControlador,
                      builder: (context, child) {
                        final categorias = categoriasControlador.categorias;

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
                                        controlador.categoriaSelecionada == null
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSurface
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                  ),
                                  selected:
                                      controlador.categoriaSelecionada == null,
                                  showCheckmark: false,
                                  onSelected: (_) {
                                    controlador.selecionarCategoria(null);
                                  },
                                  side: BorderSide(
                                    color:
                                        controlador.categoriaSelecionada == null
                                        ? Colors.transparent
                                        : Theme.of(context).colorScheme.outline,
                                    width: largura * 0.005,
                                  ),
                                ),
                                SizedBox(width: largura * 0.025),
                                ...categorias.map((categoria) {
                                  final selecionada =
                                      controlador.categoriaSelecionada ==
                                      categoria.nome;

                                  return Padding(
                                    padding: .only(right: largura * 0.025),
                                    child: ChoiceChip(
                                      label: Text(
                                        categoria.nome,
                                        overflow: .ellipsis,
                                      ),
                                      avatar: Icon(
                                        Icons.label_outline_rounded,
                                        size: largura * 0.045,
                                        color: selecionada
                                            ? categoria.cor.texto
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                      ),
                                      selected: selecionada,
                                      showCheckmark: false,
                                      selectedColor: categoria.cor.fundo,
                                      side: BorderSide(
                                        color: selecionada
                                            ? categoria.cor.texto
                                            : Theme.of(
                                                context,
                                              ).colorScheme.outline,
                                        width: largura * 0.005,
                                      ),
                                      labelStyle: TextStyle(
                                        fontSize: largura * 0.035,
                                        fontWeight: .w500,
                                        color: selecionada
                                            ? categoria.cor.texto
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                      ),
                                      onSelected: (_) {
                                        controlador.selecionarCategoria(
                                          categoria.nome,
                                        );
                                      },
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

                SizedBox(height: altura * 0.035),

                SizedBox(height: altura * 0.07),

                Expanded(
                  child: AnimatedBuilder(
                    animation: controlador,
                    builder: (context, child) {
                      final tarefas = controlador.tarefasFiltradas;

                      if (tarefas.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: .only(bottom: altura * 0.15),
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
                            iconTap: () {},
                            mostrarIcones: false,
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
