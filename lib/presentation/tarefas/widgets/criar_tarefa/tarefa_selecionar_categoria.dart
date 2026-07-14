import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controller.dart';

// Widgets
import 'categoria_choice_chip.dart';
import 'dialogo_adicionar_categoria.dart';
import 'adicionar_categoria.dart';

class TarefaSelecionarCategoria extends StatefulWidget {
  const TarefaSelecionarCategoria({
    super.key,
    required this.largura,
    required this.altura,
  });

  final double largura;
  final double altura;

  @override
  State<TarefaSelecionarCategoria> createState() =>
      _TarefaSelecionarCategoriaState();
}

class _TarefaSelecionarCategoriaState extends State<TarefaSelecionarCategoria> {
  final TarefasControlador controlador = TarefasControlador();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        return Wrap(
          spacing: widget.largura * 0.025,
          runSpacing: widget.altura * 0.01,
          children: [
            ...controlador.categorias.map((categoria) {
              return Categoria(
                nome: categoria,
                largura: widget.largura,
                selecionada: controlador.categoriaSelecionada == categoria,
                onTap: () {
                  controlador.selecionarCategoria(categoria);
                },
              );
            }),
            AdicionarCategoria(
              largura: widget.largura,
              altura: widget.altura,
              onTap: () {
                mostrarDialogoAdicionarCategoria(
                  context: context,
                  controlador: controlador,
                  largura: widget.largura,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
