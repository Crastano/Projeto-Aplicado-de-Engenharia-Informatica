import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/categoria_item.dart';

// Widgets
import 'package:pei/presentation/shared/widgets/categoria_chip.dart';

class CategoriaResultado {
  const CategoriaResultado({required this.nome, required this.cor});

  final String nome;
  final CategoriaCor cor;
}

class CategoriaDialog extends StatefulWidget {
  const CategoriaDialog({
    super.key,
    this.categoria,
    required this.largura,
    required this.altura,
  });

  final CategoriaItem? categoria;
  final double largura;
  final double altura;

  @override
  State<CategoriaDialog> createState() => _CategoriaDialogState();
}

class _CategoriaDialogState extends State<CategoriaDialog> {
  late final TextEditingController nomeControlador;
  late CategoriaCor corSelecionada;

  String? erroNome;

  bool get editar => widget.categoria != null;

  @override
  void initState() {
    super.initState();

    nomeControlador = TextEditingController(text: widget.categoria?.nome ?? '');

    corSelecionada = widget.categoria?.cor ?? coresCategorias.first;
  }

  void guardar() {
    final nome = nomeControlador.text.trim();

    if (nome.isEmpty) {
      setState(() {
        erroNome = 'Escreve o nome da categoria';
      });

      return;
    }

    Navigator.pop(context, CategoriaResultado(nome: nome, cor: corSelecionada));
  }

  @override
  void dispose() {
    nomeControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(editar ? 'Editar categoria' : 'Criar categoria'),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          TextField(
            controller: nomeControlador,
            autofocus: true,
            maxLength: 10,
            textCapitalization: .sentences,
            textInputAction: .done,
            onSubmitted: (_) => guardar(),
            onChanged: (_) {
              setState(() {
                erroNome = null;
              });
            },
            decoration: InputDecoration(
              labelText: 'Nome',
              hintText: 'Ex.: Trabalho',
              errorText: erroNome,
              errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: widget.largura * 0.005,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: widget.largura * 0.005,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: widget.largura * 0.005,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: widget.largura * 0.005,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              labelStyle: TextStyle(
                color: erroNome == null
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          SizedBox(height: widget.altura * 0.02),
          Text('Escolhe uma cor', style: TextStyle(fontWeight: .w500)),
          SizedBox(height: widget.altura * 0.01),
          Wrap(
            spacing: widget.largura * 0.025,
            runSpacing: widget.largura * 0.025,
            children: coresCategorias.map((cor) {
              final selecionada = corSelecionada == cor;

              return Tooltip(
                message: cor.nome,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      corSelecionada = cor;
                    });
                  },
                  borderRadius: .circular(widget.largura),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: widget.largura * 0.1,
                    height: widget.largura * 0.1,
                    decoration: BoxDecoration(
                      color: cor.fundo(context),
                      shape: .circle,
                      border: .all(
                        color: selecionada
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: widget.largura * 0.005,
                      ),
                    ),
                    child: selecionada
                        ? Icon(Icons.check_rounded, color: cor.texto(context))
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: widget.altura * 0.025),
          Text('Pré-visualização'),
          SizedBox(height: widget.altura * 0.01),
          CategoriaChip(
            label: nomeControlador.text.trim().isEmpty
                ? 'Categoria'
                : nomeControlador.text.trim(),
            backgroundColor: corSelecionada.fundo(context),
            textColor: corSelecionada.texto(context),
            largura: widget.largura,
            altura: widget.altura,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        FilledButton(
          onPressed: guardar,
          child: Text(editar ? 'Guardar' : 'Criar'),
        ),
      ],
    );
  }
}
