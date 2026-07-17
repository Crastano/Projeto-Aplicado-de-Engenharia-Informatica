import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// App cores
import 'package:pei/theme/app_cores.dart';

// Widget partilhados
import 'package:pei/presentation/shared/widgets/categoria_chip.dart';

class TarefaCard extends StatelessWidget {
  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.altura,
    required this.iconTap,
    required this.mostrarIcones,
  });

  final TarefaItem tarefa;
  final double largura;
  final double altura;
  final VoidCallback iconTap;
  final bool mostrarIcones;

  @override
  Widget build(BuildContext context) {
    final bool isEscuro = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = tarefa.estaCompletado
        ? isEscuro
              ? AppCores.concluidoBackgroundEscuro
              : AppCores.concluidoBackgroundClaro
        : Theme.of(context).colorScheme.surface;

    final Color cardIconColor = tarefa.estaCompletado
        ? isEscuro
              ? AppCores.concluidoTextEscuro
              : AppCores.concluidoTextClaro
        : Theme.of(context).colorScheme.onSurface;

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: .circular(largura * 0.05),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        ),
      ),
      color: cardColor,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/paginaTarefa', arguments: tarefa);
        },
        child: ListTile(
          contentPadding: .symmetric(
            horizontal: largura * 0.025,
            vertical: altura * 0.005,
          ),
          horizontalTitleGap: largura * 0.015,
          minLeadingWidth: largura * 0.1,
          leading: IconButton(
            padding: .zero,
            constraints: BoxConstraints(),
            icon: Icon(
              tarefa.estaCompletado
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: cardIconColor,
            ),
            onPressed: iconTap,
          ),
          title: Text(
            tarefa.titulo,
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(fontWeight: .w500, fontSize: largura * 0.04),
          ),
          subtitle: Row(
            children: [
              Text(
                tarefa.data,
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(fontSize: largura * 0.03),
              ),
              if (tarefa.estaRepetindo && mostrarIcones) ...[
                SizedBox(width: largura * 0.012),
                Icon(Icons.repeat, size: largura * 0.035),
              ],
              if (tarefa.temLembrete && mostrarIcones) ...[
                SizedBox(width: largura * 0.012),
                Icon(Icons.notifications_none, size: largura * 0.035),
              ],
            ],
          ),
          trailing: tarefa.category == null
              ? null
              : CategoriaChip(
                  label: tarefa.category!,
                  backgroundColor:
                      tarefa.categoryBackground ?? Colors.transparent,
                  textColor: tarefa.categoryText ?? Colors.transparent,
                  largura: largura,
                  altura: altura,
                ),
        ),
      ),
    );
  }
}
