import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'widgets/pagina_tarefa/estado_chip.dart';
import 'widgets/pagina_tarefa/tarefa_detalhes.dart';

// Cores
import 'package:pei/theme/app_cores.dart';

class PaginaTarefa extends StatelessWidget {
  const PaginaTarefa({super.key, required this.tarefa});

  final TarefaItem tarefa;

  String get dataTarefa {
    final texto = tarefa.data.trim();
    final partes = texto.split(RegExp(r'\s+'));

    if (partes.length >= 2) {
      return partes.first;
    }

    if (texto.contains(':')) {
      return 'Sem data';
    }

    return texto;
  }

  String get horaTarefa {
    final texto = tarefa.data.trim();
    final partes = texto.split(RegExp(r'\s+'));

    if (partes.length >= 2) {
      return partes.last;
    }

    if (texto.contains(':')) {
      return texto;
    }

    return 'Sem hora';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        final corEstadoFundo = tarefa.estaCompletado
            ? Theme.of(context).brightness == Brightness.dark
                  ? AppCores.concluidoBackgroundEscuro
                  : AppCores.concluidoBackgroundClaro
            : Theme.of(context).brightness == Brightness.dark
            ? AppCores.pendenteBackgroundEscuro
            : AppCores.pendenteBackgroundClaro;

        final corEstadoTexto = tarefa.estaCompletado
            ? Theme.of(context).brightness == Brightness.dark
                  ? AppCores.concluidoTextEscuro
                  : AppCores.concluidoTextClaro
            : Theme.of(context).brightness == Brightness.dark
            ? AppCores.pendenteTextEscuro
            : AppCores.pendenteTextClaro;

        return AppScaffold(
          title: '',
          textSize: largura * 0.07,
          actions: [
            Padding(
              padding: .only(right: largura * 0.05),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Editar tarefa',
                    onPressed: () {},
                    icon: Icon(Icons.edit_rounded, size: largura * 0.075),
                  ),
                  SizedBox(width: largura * 0.025),
                  IconButton(
                    tooltip: 'Eliminar tarefa',
                    onPressed: () {},
                    icon: Icon(
                      Icons.close_rounded,
                      size: largura * 0.085,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ],
              ),
            ),
          ],
          automaticallyImplyLeading: true,
          currentIndex: null,
          floatingActionButton: false,
          bottomNavigationBar: false,
          largura: largura,

          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: .onDrag,
                  child: Padding(
                    padding: .all(largura * 0.06),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                tarefa.titulo,
                                style: TextStyle(
                                  fontSize: largura * 0.055,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ),

                            SizedBox(width: largura * 0.03),

                            EstadoChip(
                              texto: tarefa.estaCompletado
                                  ? 'Concluída'
                                  : 'Pendente',
                              corFundo: corEstadoFundo,
                              corTexto: corEstadoTexto,
                              largura: largura,
                            ),
                          ],
                        ),

                        SizedBox(height: altura * 0.005),

                        Divider(),

                        SizedBox(height: altura * 0.01),

                        EstadoChip(
                          texto: tarefa.category ?? 'Sem categoria',
                          corFundo:
                              tarefa.categoryBackground ??
                              Theme.of(context).colorScheme.surface,
                          corTexto:
                              tarefa.categoryText ??
                              Theme.of(context).colorScheme.onSurface,
                          largura: largura,
                        ),

                        SizedBox(height: altura * 0.01),

                        LinhaDetalhesTarefa(
                          icone: Icons.calendar_today_outlined,
                          titulo: 'Data',
                          valor: dataTarefa,
                          largura: largura,
                          altura: altura,
                        ),
                        LinhaDetalhesTarefa(
                          icone: Icons.access_time_rounded,
                          titulo: 'Hora',
                          valor: horaTarefa,
                          largura: largura,
                          altura: altura,
                        ),
                        LinhaDetalhesTarefa(
                          icone: Icons.repeat_rounded,
                          titulo: 'Periodicidade',
                          valor: tarefa.estaRepetindo
                              ? 'Tarefa repetida'
                              : 'Não se repete',
                          largura: largura,
                          altura: altura,
                        ),

                        LinhaDetalhesTarefa(
                          icone: Icons.notifications_none_rounded,
                          titulo: 'Lembrete',
                          valor: tarefa.temLembrete
                              ? 'Lembrete ativo'
                              : 'Sem lembrete',
                          largura: largura,
                          altura: altura,
                        ),

                        LinhaDetalhesTarefa(
                          icone: Icons.chat_bubble_outline_rounded,
                          titulo: 'Notas',
                          valor: 'Não há notas',
                          largura: largura,
                          altura: altura,
                        ),

                        LinhaDetalhesTarefa(
                          icone: Icons.attach_file_rounded,
                          titulo: 'Anexo',
                          valor: 'Não há anexos',
                          largura: largura,
                          altura: altura,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: .all(largura * 0.06),
                child: Align(
                  alignment: .centerRight,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(
                      tarefa.estaCompletado
                          ? 'Marcar como não concluído'
                          : 'Marcar como concluído',
                      style: TextStyle(
                        fontSize: largura * 0.04,
                        fontWeight: .w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
