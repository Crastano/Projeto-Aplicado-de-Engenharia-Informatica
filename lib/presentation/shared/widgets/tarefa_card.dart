import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

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
    required this.mostrarIcones,
  });

  final TarefaItem tarefa;
  final double largura;
  final double altura;
  final VoidCallback iconTap;
  final bool mostrarIcones;

  @override
  State<TarefaCard> createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {
  @override
  Widget build(BuildContext context) {
    final bool isEscuro = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = widget.tarefa.estaCompletado
        ? isEscuro
              ? AppCores.concluidoBackgroundEscuro
              : AppCores.concluidoBackgroundClaro
        : Theme.of(context).colorScheme.surface;

    final Color cardIconColor = widget.tarefa.estaCompletado
        ? isEscuro
              ? AppCores.concluidoTextEscuro
              : AppCores.concluidoTextClaro
        : Theme.of(context).colorScheme.onSurface;

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: .circular(widget.largura * 0.05),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline, // border color
          width: widget.largura * 0.005, // border width
        ),
      ),
      color: cardColor,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/paginaTarefa', arguments: widget.tarefa);
        },
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              widget.tarefa.estaCompletado
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
                style: TextStyle(fontSize: widget.largura * 0.03,),
              ),
              if (widget.tarefa.estaRepetindo && widget.mostrarIcones) ...[
                SizedBox(width: widget.largura * 0.012),
                Icon(Icons.repeat, size: widget.largura * 0.035),
              ],
              if (widget.tarefa.temLembrete && widget.mostrarIcones) ...[
                SizedBox(width: widget.largura * 0.012),
                Icon(Icons.notifications_none, size: widget.largura * 0.035),
              ],
            ],
          ),
          trailing: widget.tarefa.category == null ? null : CategoriaChip(
            label: widget.tarefa.category ?? '',
            backgroundColor: widget.tarefa.categoryBackground ?? Colors.transparent,
            textColor: widget.tarefa.categoryText ?? Colors.transparent,
            largura: widget.largura,
            altura: widget.altura,
          ),
        ),
      ),
    );
  }
}
