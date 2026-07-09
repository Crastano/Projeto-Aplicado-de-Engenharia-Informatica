import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// App cores
import 'package:pei/theme/app_cores.dart';

// Widget partilhados
import 'package:pei/presentation/shared/widgets/categoria_chip.dart';

class TarefaCard extends StatefulWidget {
  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.altura,
    required this.iconTap,
    required this.cardTap,
  });

  final TarefaItem tarefa;
  final double largura;
  final double altura;
  final VoidCallback iconTap;
  final VoidCallback cardTap;

  @override
  State<TarefaCard> createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {
  @override
  Widget build(BuildContext context) {
    final bool isEscuro = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = widget.tarefa.isCompleted
        ? isEscuro
              ? AppCores.concluidoBackgroundEscuro
              : AppCores.concluidoBackgroundClaro
        : Theme.of(context).colorScheme.surface;

    final Color cardIconColor = widget.tarefa.isCompleted
        ? isEscuro
              ? AppCores.concluidoTextEscuro
              : AppCores.concluidoTextClaro
        : Theme.of(context).colorScheme.onSurface;

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.largura * 0.05),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline, // border color
          width: widget.largura * 0.005, // border width
        ),
      ),
      color: cardColor,
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: widget.cardTap,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              widget.tarefa.isCompleted
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: cardIconColor,
            ),
            onPressed: widget.iconTap,
          ),
          title: Text(
            widget.tarefa.titulo,
            style: TextStyle(
              fontWeight: .w500,
              fontSize: widget.largura * 0.04,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                widget.tarefa.data,
                style: TextStyle(fontSize: widget.largura * 0.03),
              ),
              if (widget.tarefa.isRepeating) ...[
                SizedBox(width: widget.largura * 0.012),
                Icon(Icons.repeat, size: widget.largura * 0.035),
              ],
              if (widget.tarefa.hasNotification) ...[
                SizedBox(width: widget.largura * 0.012),
                Icon(Icons.notifications_none, size: widget.largura * 0.035),
              ],
            ],
          ),
          trailing: CategoriaChip(
            label: widget.tarefa.category,
            backgroundColor: widget.tarefa.categoryBackground,
            textColor: widget.tarefa.categoryText,
            largura: widget.largura,
            altura: widget.altura,
          ),
        ),
      ),
    );
  }
}
