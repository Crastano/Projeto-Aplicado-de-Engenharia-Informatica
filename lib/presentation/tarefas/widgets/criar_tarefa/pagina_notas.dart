import 'package:flutter/material.dart';

class PaginaNotas extends StatefulWidget {
  const PaginaNotas({
    super.key,
    required this.notaInicial,
    required this.largura,
  });

  final double largura;
  final String notaInicial;

  @override
  State<PaginaNotas> createState() => _PaginaNotasState();
}

class _PaginaNotasState extends State<PaginaNotas> {
  late final TextEditingController notaControlador;

  @override
  void initState() {
    super.initState();

    notaControlador = TextEditingController(text: widget.notaInicial);
  }

  @override
  void dispose() {
    notaControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notas'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, notaControlador.text.trim());
            },
            icon: Icon(
              Icons.chevron_left_outlined,
              size: widget.largura * 0.075,
            ),
          ),
        ),
        body: Padding(
          padding: .all(widget.largura * 0.06),
          child: TextField(
            controller: notaControlador,
            autofocus: true,
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: .top,
            keyboardType: .multiline,
            textCapitalization: .sentences,
            decoration: InputDecoration(
              hintText: 'Escreve uma nota...',
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.largura * 0.005,
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.largura * 0.005,
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.largura * 0.005,
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: .circular(widget.largura * 0.025),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
