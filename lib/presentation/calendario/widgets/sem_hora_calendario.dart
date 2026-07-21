import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Widgets
import 'tarefa_sem_hora_card.dart';

class TarefasSemHoraCalendario extends StatelessWidget {
  TarefasSemHoraCalendario({
    super.key,
    required this.dias,
    required this.tarefas,
    required this.largura,
  });

  final List<DateTime> dias;
  final List<TarefaModelo> tarefas;
  final double largura;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final tarefasPorDia = dias.map((dia) {
      return controlador.tarefasSemHoraDoDia(dia, tarefas);
    }).toList();

    final existemTarefasSemHora = tarefasPorDia.any((tarefasDoDia) {
      return tarefasDoDia.isNotEmpty;
    });

    if (!existemTarefasSemHora) {
      return SizedBox.shrink();
    }

    final umDia = dias.length == 1;
    final larguraHoras = largura * 0.15;

    return Padding(
      padding: .only(bottom: largura * 0.025),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: larguraHoras),
              Expanded(
                child: Text(
                  'Tarefas sem hora',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: largura * 0.045,
                    fontWeight: .w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: largura * 0.02),
          Row(
            crossAxisAlignment: .start,
            children: [
              SizedBox(width: larguraHoras),
              ...List.generate(dias.length, (diaIndex) {
                final tarefasDoDia = tarefasPorDia[diaIndex];

                return Expanded(
                  child: Padding(
                    padding: .all(largura * 0.005),
                    child: tarefasDoDia.isEmpty
                        ? Center(
                            child: Text(
                              '—',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tarefasDoDia.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: largura * 0.01);
                            },
                            itemBuilder: (context, tarefaIndex) {
                              final tarefa = tarefasDoDia[tarefaIndex];

                              return TarefaSemHoraCard(
                                tarefa: tarefa,
                                largura: largura,
                                compacto: !umDia,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/paginaTarefa',
                                    arguments: tarefa.id,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
