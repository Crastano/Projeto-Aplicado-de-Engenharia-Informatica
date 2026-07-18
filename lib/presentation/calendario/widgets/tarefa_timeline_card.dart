import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';
import 'package:pei/controller/categorias_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

class TarefaTimelineCard extends StatelessWidget {
  TarefaTimelineCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.umDia,
    this.onTap,
  });

  final TarefaItem tarefa;
  final double largura;
  final bool umDia;
  final VoidCallback? onTap;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final categoria = CategoriasControlador.instancia.obterPorId(
      tarefa.categoryId,
    );

    return Card.filled(
      margin: .zero,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(largura * 0.025),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        ),
      ),
      color:
          categoria?.cor.fundo(context) ??
          Theme.of(context).colorScheme.surface,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.all(largura * 0.02),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    tarefa.titulo,
                    maxLines: umDia ? 2 : 3,
                    overflow: .ellipsis,
                    style: TextStyle(
                      color: categoria?.cor.texto(context),
                      fontSize: umDia ? largura * 0.0425 : largura * 0.03,
                      fontWeight: .w500,
                      height: 1.1,
                    ),
                  ),
                  if (umDia) ...[
                    SizedBox(height: largura * 0.005),
                    Text(
                      '${controlador.formatarHora(tarefa.dataHora)}'
                      " · ${tarefa.category ?? 'Sem categoria'}",
                      style: TextStyle(
                        color: categoria?.cor.texto(context),
                        fontSize: largura * 0.03,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
