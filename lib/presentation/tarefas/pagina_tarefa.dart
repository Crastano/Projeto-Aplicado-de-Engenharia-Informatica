import 'package:flutter/material.dart';

// Controlaodr
import 'package:pei/controller/tarefas_estado.dart';
import 'package:pei/controller/categorias_controlador.dart';

// Enums
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_lembrete.dart';
import 'package:pei/enums/unidade_periodicidade.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

// Widgets
import 'package:pei/presentation/shared/layout/app_scaffold.dart';
import 'package:pei/presentation/tarefas/criar_tarefa.dart';
import 'widgets/pagina_tarefa/estado_chip.dart';
import 'widgets/pagina_tarefa/tarefa_detalhes.dart';

// App Cores
import 'package:pei/theme/app_cores.dart';

// Utils
import 'package:pei/utils/formatador_data_hora.dart';

class PaginaTarefa extends StatelessWidget {
  const PaginaTarefa({super.key, required this.tarefaId});

  final String tarefaId;

  Future<void> editar(BuildContext context, TarefaItem tarefa) async {
    await Navigator.push<TarefaItem>(
      context,
      MaterialPageRoute(builder: (context) => CriarTarefa(tarefa: tarefa)),
    );
  }

  Future<void> eliminar(BuildContext context, TarefaItem tarefa) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Eliminar tarefa?'),
          content: Text('Queres eliminar “${tarefa.titulo}”?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmado != true || !context.mounted) return;

    TarefasEstado.instancia.eliminar(tarefa.id);
    Navigator.pop(context);
  }

  String formatarData(DateTime data) {
    return FormatadorDataHora.data(data);
  }

  String formatarHora(DateTime data) {
    return FormatadorDataHora.hora(data);
  }

  String formatarPeriodicidade(TarefaItem tarefa) {
    final periodicidade = tarefa.periodicidade;

    if (periodicidade == Periodicidade.personalizada) {
      final intervalo = tarefa.periodicidadeIntervalo;
      final unidade = tarefa.periodicidadeUnidade;

      if (intervalo != null && unidade != null) {
        return switch (unidade) {
          UnidadePeriodicidade.dias =>
            intervalo == 1 ? 'Todos os dias' : 'A cada $intervalo dias',
          UnidadePeriodicidade.semanas =>
            intervalo == 1 ? 'Todas as semanas' : 'A cada $intervalo semanas',
          UnidadePeriodicidade.meses =>
            intervalo == 1 ? 'Todos os meses' : 'A cada $intervalo meses',
          UnidadePeriodicidade.anos =>
            intervalo == 1 ? 'Todos os anos' : 'A cada $intervalo anos',
        };
      }
    }

    return switch (periodicidade) {
      Periodicidade.nenhuma => 'Não se repete',
      Periodicidade.diaria => 'Diariamente',
      Periodicidade.semanal => 'Semanalmente',
      Periodicidade.mensal => 'Mensalmente',
      Periodicidade.anual => 'Anualmente',
      Periodicidade.personalizada => 'Periodicidade personalizada',
    };
  }

  String formatarLembrete(TarefaItem tarefa) {
    final lembrete = tarefa.lembrete;

    if (lembrete == Lembrete.personalizada) {
      final quantidade = tarefa.lembreteQuantidade;
      final unidade = tarefa.lembreteUnidade;

      if (quantidade != null && unidade != null) {
        return switch (unidade) {
          UnidadeLembrete.minutos =>
            quantidade == 1 ? '1 minuto antes' : '$quantidade minutos antes',
          UnidadeLembrete.horas =>
            quantidade == 1 ? '1 hora antes' : '$quantidade horas antes',
          UnidadeLembrete.dias =>
            quantidade == 1 ? '1 dia antes' : '$quantidade dias antes',
        };
      }
    }

    return switch (lembrete) {
      Lembrete.nenhum => 'Sem lembrete',
      Lembrete.noMomento => 'Na hora da tarefa',
      Lembrete.cincoMinutos => '5 minutos antes',
      Lembrete.dezMinutos => '10 minutos antes',
      Lembrete.quinzeMinutos => '15 minutos antes',
      Lembrete.trintaMinutos => '30 minutos antes',
      Lembrete.umaHora => '1 hora antes',
      Lembrete.umDia => '1 dia antes',
      Lembrete.personalizada => 'Lembrete personalizado',
    };
  }

  @override
  Widget build(BuildContext context) {
    final tarefasEstado = TarefasEstado.instancia;

    return AnimatedBuilder(
      animation: tarefasEstado,
      builder: (context, _) {
        final tarefa = tarefasEstado.obterPorId(tarefaId);

        if (tarefa == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Esta tarefa já não existe.')),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final largura = constraints.maxWidth;
            final altura = constraints.maxHeight;
            final escuro = Theme.of(context).brightness == Brightness.dark;

            final corEstadoFundo = tarefa.estaCompletado
                ? escuro
                      ? AppCores.concluidoBackgroundEscuro
                      : AppCores.concluidoBackgroundClaro
                : tarefa.estaAtrasado
                ? escuro
                      ? AppCores.atrasadoBackgroundEscuro
                      : AppCores.atrasadoBackgroundClaro
                : escuro
                ? AppCores.pendenteBackgroundEscuro
                : AppCores.pendenteBackgroundClaro;

            final corEstadoTexto = tarefa.estaCompletado
                ? escuro
                      ? AppCores.concluidoTextEscuro
                      : AppCores.concluidoTextClaro
                : tarefa.estaAtrasado
                ? escuro
                      ? AppCores.atrasadoTextEscuro
                      : AppCores.atrasadoTextClaro
                : escuro
                ? AppCores.pendenteTextEscuro
                : AppCores.pendenteTextClaro;

            final textoEstado = tarefa.estaCompletado
                ? 'Concluída'
                : tarefa.estaAtrasado
                ? 'Atrasada'
                : 'Pendente';

            final categoria =
      CategoriasControlador.instancia.obterPorId(
        tarefa.categoryId,
      );

            return AppScaffold(
              title: '',
              textSize: largura * 0.07,
              actions: [
                IconButton(
                  tooltip: 'Editar tarefa',
                  onPressed: () => editar(context, tarefa),
                  icon: Icon(Icons.edit_rounded, size: largura * 0.07),
                ),
                Padding(
                  padding: .only(right: largura * 0.03),
                  child: IconButton(
                    tooltip: 'Eliminar tarefa',
                    onPressed: () => eliminar(context, tarefa),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: largura * 0.075,
                      color: Theme.of(context).colorScheme.onError,
                    ),
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
                      padding: .all(largura * 0.06),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            crossAxisAlignment: .start,
                            children: [
                              Expanded(
                                child: Text(
                                  tarefa.titulo,
                                  style: TextStyle(
                                    fontSize: largura * 0.06,
                                    fontWeight: .w600,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              SizedBox(width: largura * 0.03),
                              EstadoChip(
                                texto: textoEstado,
                                corFundo: corEstadoFundo,
                                corTexto: corEstadoTexto,
                                largura: largura,
                              ),
                            ],
                          ),
                          SizedBox(height: altura * 0.015),
                          EstadoChip(
                            texto: tarefa.category ?? 'Sem categoria',
                            corFundo:
                                categoria?.cor.fundo(context) ??
                                Theme.of(context).colorScheme.surface,
                            corTexto:
                                categoria?.cor.texto(context) ??
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            largura: largura,
                          ),
                          SizedBox(height: altura * 0.02),
                          Divider(),
                          LinhaDetalhesTarefa(
                            icone: Icons.calendar_today_outlined,
                            titulo: 'Data',
                            valor: formatarData(tarefa.data),
                            largura: largura,
                            altura: altura,
                          ),
                          if (tarefa.temHora)
                            LinhaDetalhesTarefa(
                              icone: Icons.access_time_rounded,
                              titulo: 'Hora',
                              valor: formatarHora(tarefa.dataHora),
                              largura: largura,
                              altura: altura,
                            ),
                          if (tarefa.dataLimite != null)
                            LinhaDetalhesTarefa(
                              icone: Icons.flag_outlined,
                              titulo: 'Data limite',
                              valor: formatarData(tarefa.dataLimite!),
                              largura: largura,
                              altura: altura,
                            ),
                          LinhaDetalhesTarefa(
                            icone: Icons.repeat_rounded,
                            titulo: 'Periodicidade',
                            valor: formatarPeriodicidade(tarefa),
                            largura: largura,
                            altura: altura,
                          ),
                          LinhaDetalhesTarefa(
                            icone: Icons.notifications_none_rounded,
                            titulo: 'Lembrete',
                            valor: formatarLembrete(tarefa),
                            largura: largura,
                            altura: altura,
                          ),
                          LinhaDetalhesTarefa(
                            icone: Icons.chat_bubble_outline_rounded,
                            titulo: 'Notas',
                            valor: tarefa.notas?.trim().isNotEmpty == true
                                ? tarefa.notas!
                                : 'Não há notas',
                            largura: largura,
                            altura: altura,
                          ),
                          LinhaDetalhesTarefa(
                            icone: Icons.attach_file_rounded,
                            titulo: 'Anexos',
                            valor: tarefa.anexos.isEmpty
                                ? 'Não há anexos'
                                : '${tarefa.anexos.length} '
                                      '${tarefa.anexos.length == 1 ? 'anexo' : 'anexos'}',
                            largura: largura,
                            altura: altura,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: .all(largura * 0.06),
                      child: SizedBox(
                        width: .infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            tarefasEstado.alternarConclusao(tarefa.id);
                          },
                          icon: Icon(
                            tarefa.estaCompletado
                                ? Icons.undo_rounded
                                : Icons.check_rounded,
                          ),
                          label: Text(
                            tarefa.estaCompletado
                                ? 'Marcar como pendente'
                                : 'Marcar como concluída',
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
      },
    );
  }
}
