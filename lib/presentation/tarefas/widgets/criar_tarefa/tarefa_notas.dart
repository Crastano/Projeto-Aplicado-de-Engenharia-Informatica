import 'package:flutter/material.dart';

// Widgets personais
import 'package:pei/presentation/tarefas/widgets/criar_tarefa/pagina_notas.dart';

class TarefaNotas extends StatefulWidget {
  const TarefaNotas({super.key, required this.largura, this.notaInicial = ''});

  final double largura;
  final String notaInicial;

  @override
  State<TarefaNotas> createState() => _TarefaNotasState();
}

class _TarefaNotasState extends State<TarefaNotas> {
  late String nota;

  @override
  void initState() {
    super.initState();
    nota = widget.notaInicial;
  }

  Future<void> abrirPaginaNotas() async {
    final String? resultado = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaginaNotas(notaInicial: nota);
        },
      ),
    );

    if (!mounted || resultado == null) return;

    setState(() {
      nota = resultado.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Icon(Icons.notes_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Notas',
              style: TextStyle(
                fontWeight: .w500,
                fontSize: widget.largura * 0.045,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: abrirPaginaNotas,
              child: Text(
                nota.isEmpty ? 'Adicionar' : 'Editar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: .w500,
                  fontSize: widget.largura * 0.04
                ),
              ),
            ),
          ],
        ),

        if (nota.isNotEmpty) ...[
          SizedBox(height: widget.largura * 0.025),
          Container(
            width: .infinity,
            padding: EdgeInsets.all(widget.largura * 0.035),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(widget.largura * 0.025),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: widget.largura * 0.005,
              ),
            ),
            child: Text(
              nota,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: widget.largura * 0.037,
                height: 1.4,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
