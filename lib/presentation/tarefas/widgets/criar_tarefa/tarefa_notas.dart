import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Widgets
import 'pagina_notas.dart';

class TarefaNotas extends StatelessWidget {
  const TarefaNotas({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> abrirPaginaNotas(BuildContext context) async {
    final resultado = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaginaNotas(notaInicial: controlador.nota, largura: largura);
        },
      ),
    );

    if (resultado != null) controlador.atualizarNota(resultado);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final nota = controlador.nota;

        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Icon(Icons.notes_outlined, size: largura * 0.075),
                  SizedBox(width: largura * 0.04),
                  Expanded(
                    child: Text(
                      'Notas',
                      style: TextStyle(
                        fontWeight: .w500,
                        fontSize: largura * 0.045,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => abrirPaginaNotas(context),
                    child: Text(
                      nota.isEmpty ? 'Adicionar' : 'Editar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: .w500,
                        fontSize: largura * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
              if (nota.isNotEmpty) ...[
                SizedBox(height: largura * 0.02),
                Container(
                  width: .infinity,
                  padding: .all(largura * 0.035),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: .circular(largura * 0.025),
                    border: .all(
                      color: Theme.of(context).colorScheme.outline,
                      width: largura * 0.005,
                    ),
                  ),
                  child: Text(
                    nota,
                    style: TextStyle(fontSize: largura * 0.037, height: 1.4),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
