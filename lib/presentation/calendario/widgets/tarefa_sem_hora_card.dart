import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

class TarefaSemHoraCard extends StatelessWidget {
  const TarefaSemHoraCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.compacto,
    this.onTap,
  });

  final TarefaItem tarefa;
  final double largura;
  final bool compacto;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largura * 0.025),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(compacto ? largura * 0.015 : largura * 0.025),
          child: Row(
            children: [
              Icon(
                Icons.event_note_outlined,
                size: compacto ? largura * 0.035 : largura * 0.055,
              ),
              SizedBox(width: largura * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tarefa.titulo,
                      maxLines: compacto ? 2 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: compacto ? largura * 0.028 : largura * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
