import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

Future<void> mostrarDialogoAdicionarCategoria({
  required BuildContext context,
  required TarefasController controlador,
  required double largura,
}) async {
  String nomeCategoria = '';

  final novaCategoria = await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adicionar categoria'),
        content: TextField(
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: 'Nome da categoria',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            nomeCategoria = value;
          },
          onSubmitted: (value) {
            final categoria = value.trim();

            if (categoria.isEmpty) return;

            Navigator.of(context).pop(categoria);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final categoria = nomeCategoria.trim();

              if (categoria.isEmpty) return;

              Navigator.of(context).pop(categoria);
            },
            child: const Text('Adicionar'),
          ),
        ],
      );
    },
  );

  if (novaCategoria == null) return;

  if (!context.mounted) return;

  controlador.adicionarCategoria(novaCategoria);
}
