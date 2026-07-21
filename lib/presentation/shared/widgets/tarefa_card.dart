import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/categorias_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Widgets
import 'package:pei/presentation/shared/widgets/categoria_chip.dart';

// App Cores
import 'package:pei/theme/app_cores.dart';

// Utils
import 'package:pei/utils/formatador_data_hora.dart';

class TarefaCard extends StatelessWidget {
  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.largura,
    required this.altura,
    required this.iconTap,
    required this.mostrarIcones,
  });

  final TarefaModelo tarefa;
  final double largura;
  final double altura;
  final VoidCallback iconTap;
  final bool mostrarIcones;

  @override
  Widget build(BuildContext context) {
    final bool escuro = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = tarefa.estaCompletado
        ? escuro
              ? AppCores.concluidoBackgroundEscuro
              : AppCores.concluidoBackgroundClaro
        : tarefa.estaAtrasado
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.surface;

    final Color iconColor = tarefa.estaCompletado
        ? escuro
              ? AppCores.concluidoTextEscuro
              : AppCores.concluidoTextClaro
        : tarefa.estaAtrasado
        ? Theme.of(context).colorScheme.onError
        : Theme.of(context).colorScheme.onSurface;

    final String textoData = tarefa.temHora
        ? FormatadorDataHora.dataHora(tarefa.dataHora)
        : FormatadorDataHora.data(tarefa.data);

    final categoria = CategoriasControlador.instancia.obterPorId(
      tarefa.categoryId,
    );

    return Card(
      margin: .zero,
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
          Navigator.pushNamed(context, '/paginaTarefa', arguments: tarefa.id);
        },
        child: ListTile(
          contentPadding: .symmetric(
            horizontal: largura * 0.025,
            vertical: altura * 0.005,
          ),
          horizontalTitleGap: largura * 0.015,
          minLeadingWidth: largura * 0.1,
          leading: IconButton(
            tooltip: tarefa.estaCompletado
                ? 'Marcar como pendente'
                : 'Marcar como concluída',
            padding: .zero,
            constraints: BoxConstraints(),
            icon: Icon(
              tarefa.estaCompletado
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: iconColor,
            ),
            onPressed: iconTap,
          ),
          title: Text(
            tarefa.titulo,
            maxLines: 2,
            overflow: .ellipsis,
            style: TextStyle(
              fontWeight: .w500,
              fontSize: largura * 0.04,
              decoration: tarefa.estaCompletado
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  textoData,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: TextStyle(fontSize: largura * 0.03),
                ),
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
              : ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: largura * 0.3),
                  child: CategoriaChip(
                    label: tarefa.category!,
                    backgroundColor:
                        categoria?.cor.fundo(context) ??
                        Theme.of(context).colorScheme.surface,
                    textColor:
                        categoria?.cor.texto(context) ??
                        Theme.of(context).colorScheme.onSurfaceVariant,
                    largura: largura,
                    altura: altura,
                  ),
                ),
        ),
      ),
    );
  }
}
