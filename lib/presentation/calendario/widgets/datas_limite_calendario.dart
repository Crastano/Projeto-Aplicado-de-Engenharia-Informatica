import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Widgets
import 'tarefa_data_limite_card.dart';

class DatasLimiteCalendario extends StatelessWidget {
  DatasLimiteCalendario({
    super.key,
    required this.dias,
    required this.tarefas,
    required this.largura,
    required this.altura,
  });

  final List<DateTime> dias;
  final List<TarefaModelo> tarefas;
  final double largura;
  final double altura;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final List<List<TarefaModelo>> tarefasPorDia = dias.map((dia) {
      return controlador.tarefasComDataLimiteNoDia(dia, tarefas);
    }).toList();

    final bool existemDatasLimite = tarefasPorDia.any(
      (lista) => lista.isNotEmpty,
    );

    if (!existemDatasLimite) {
      return const SizedBox.shrink();
    }

    final bool umDia = dias.length == 1;
    final double larguraHoras = largura * 0.15;

    return Padding(
      padding: .only(bottom: largura * 0.025),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [
              SizedBox(width: larguraHoras),
              Text(
                'Datas limite',
                style: TextStyle(fontSize: largura * 0.045, fontWeight: .w500),
              ),
            ],
          ),
          SizedBox(height: largura * 0.02),
          Row(
            crossAxisAlignment: .start,
            children: [
              SizedBox(width: larguraHoras),
              ...List.generate(dias.length, (index) {
                final tarefasDoDia = tarefasPorDia[index];

                return Expanded(
                  child: Padding(
                    padding: .all(largura * 0.005),
                    child: tarefasDoDia.isEmpty
                        ? Center(
                            child: Text(
                              'Sem prazo',
                              style: TextStyle(
                                fontSize: largura * 0.035,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tarefasDoDia.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: largura * 0.01);
                            },
                            itemBuilder: (context, tarefaIndex) {
                              return TarefaDataLimiteCard(
                                tarefa: tarefasDoDia[tarefaIndex],
                                largura: largura,
                                compacto: !umDia,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/paginaTarefa',
                                    arguments: tarefasDoDia[tarefaIndex].id,
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
