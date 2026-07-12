import 'package:flutter/material.dart';

class PaginaNotas extends StatefulWidget {
  const PaginaNotas({
    super.key,
    required this.notaInicial,
  });

  final String notaInicial;

  @override
  State<PaginaNotas> createState() => _PaginaNotasState();
}

class _PaginaNotasState extends State<PaginaNotas> {
  late final TextEditingController notaController;

  @override
  void initState() {
    super.initState();

    notaController = TextEditingController(
      text: widget.notaInicial,
    );
  }

  @override
  void dispose() {
    notaController.dispose();
    super.dispose();
  }

  void voltar() {
    Navigator.pop(
      context,
      notaController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        voltar();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notas'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: voltar,
            icon: const Icon(
              Icons.arrow_back_outlined,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: TextField(
            controller: notaController,
            autofocus: true,
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Escreve uma nota...',
              filled: true,
              fillColor: colors.surface,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}