import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/categorias_controlador.dart';

// Modelos
import 'package:pei/models/categoria_item.dart';
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/shared/widgets/categoria_chip.dart';

// Widgets
import 'widgets/categoria_dialog.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final CategoriasController controlador = CategoriasController();

  late final double largura;
  late final double altura;

  Future<void> abrirDialog({CategoriaItem? categoria}) async {
    final resultado = await showDialog<CategoriaResultado>(
      context: context,
      builder: (context) {
        return CategoriaDialog(
          categoria: categoria,
          largura: largura,
          altura: altura,
        );
      },
    );

    if (resultado == null || !mounted) return;

    final sucesso = categoria == null
        ? controlador.adicionarCategoria(
            nome: resultado.nome,
            cor: resultado.cor,
          )
        : controlador.editarCategoria(
            id: categoria.id,
            nome: resultado.nome,
            cor: resultado.cor,
          );

    if (sucesso) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Já existe uma categoria com esse nome.')),
    );
  }

  Future<void> eliminar(CategoriaItem categoria) async {
    final eliminar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Eliminar categoria?'),
          content: Text(
            'Queres eliminar a categoria '
            '"${categoria.nome}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (eliminar != true) return;

    controlador.eliminarCategoria(categoria.id);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        largura = constraints.maxWidth;
        altura = constraints.maxHeight;

        return AppScaffold(
          title: 'Categorias',
          textSize: largura * 0.07,
          automaticallyImplyLeading: true,
          currentIndex: null,
          floatingActionButton: false,
          bottomNavigationBar: false,
          largura: largura,
          actions: [
            TextButton(
              onPressed: abrirDialog,
              child: Text(
                'Adicionar',
                style: TextStyle(fontSize: largura * 0.035, fontWeight: .w500),
              ),
            ),
          ],

          body: AnimatedBuilder(
            animation: controlador,
            builder: (context, child) {
              final categorias = controlador.categorias;

              if (categorias.isEmpty) {
                return Center(
                  child: Padding(
                    padding: .all(largura * 0.06),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Icon(Icons.category_outlined, size: largura * 0.2),
                        SizedBox(height: altura * 0.025),
                        Text(
                          'Ainda não tens categorias',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: .w500,
                            fontSize: largura * 0.075,
                          ),
                        ),
                        SizedBox(height: altura * 0.01),
                        FilledButton.icon(
                          onPressed: abrirDialog,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Criar categoria'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: .all(largura * 0.06),
                itemCount: categorias.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: altura * 0.02);
                },
                itemBuilder: (context, index) {
                  final categoria = categorias[index];

                  return Card(
                    margin: .zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(largura * 0.05),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: largura * 0.005,
                      ),
                    ),
                    child: Padding(
                      padding: .all(largura * 0.03),
                      child: Row(
                        children: [
                          Spacer(),
                          CategoriaChip(
                            label: categoria.nome,
                            backgroundColor: categoria.cor.fundo,
                            textColor: categoria.cor.texto,
                            largura: largura,
                            altura: altura,
                          ),
                          Spacer(),
                          IconButton(
                            tooltip: 'Editar categoria',
                            onPressed: () {
                              abrirDialog(categoria: categoria);
                            },
                            icon: Icon(Icons.edit_outlined),
                          ),
                          IconButton(
                            tooltip: 'Eliminar categoria',
                            onPressed: () {
                              eliminar(categoria);
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
