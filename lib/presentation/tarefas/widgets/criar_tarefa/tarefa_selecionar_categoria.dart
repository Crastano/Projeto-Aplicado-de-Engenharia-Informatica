import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/categorias_controlador.dart';
import 'package:pei/controller/tarefas_controlador.dart';

// Modelos
import 'package:pei/models/categoria_item.dart';

// Widgets
import 'package:pei/presentation/categorias/widgets/categoria_dialog.dart';
import 'adicionar_categoria.dart';
import 'categoria_choice_chip.dart';

class TarefaSelecionarCategoria extends StatelessWidget {
  const TarefaSelecionarCategoria({
    super.key,
    required this.controlador,
    required this.largura,
    required this.altura,
  });

  final TarefasControlador controlador;
  final double largura;
  final double altura;

  Future<void> adicionarCategoria(BuildContext context) async {
    final resultado = await showDialog<CategoriaResultado>(
      context: context,
      builder: (context) {
        return CategoriaDialog(largura: largura, altura: altura);
      },
    );

    if (resultado == null || !context.mounted) return;

    final CategoriasControlador categorias = CategoriasControlador.instancia;
    final bool sucesso = categorias.adicionarCategoria(
      nome: resultado.nome,
      cor: resultado.cor,
    );

    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Já existe uma categoria com esse nome.')),
      );
      return;
    }

    final CategoriaItem? criada = categorias.obterPorNome(resultado.nome);
    controlador.selecionarCategoria(criada?.id);
  }

  @override
  Widget build(BuildContext context) {
    final categorias = CategoriasControlador.instancia;

    return AnimatedBuilder(
      animation: categorias,
      builder: (context, _) {
        return ListenableBuilder(
          listenable: controlador,
          builder: (context, _) {
            return Wrap(
              spacing: largura * 0.025,
              runSpacing: altura * 0.01,
              children: [
                CategoriaChoiceChip(
                  nome: 'Sem categoria',
                  largura: largura,
                  selecionada: controlador.categoriaIdSelecionada == null,
                  onTap: () {
                    controlador.selecionarCategoria(null);
                  },
                ),
                ...categorias.categorias.map((categoria) {
                  return CategoriaChoiceChip(
                    nome: categoria.nome,
                    largura: largura,
                    selecionada:
                        controlador.categoriaIdSelecionada == categoria.id,
                    onTap: () => controlador.selecionarCategoria(categoria.id),
                  );
                }),
                AdicionarCategoria(
                  largura: largura,
                  altura: altura,
                  onTap: () => adicionarCategoria(context),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
