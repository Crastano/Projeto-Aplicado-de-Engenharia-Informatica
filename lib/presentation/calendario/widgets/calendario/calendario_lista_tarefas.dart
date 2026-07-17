import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/calendario_controlador.dart';

// Modelos
import 'package:pei/models/tarefa_item.dart';

//Widgets
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';
import '../tarefa_data_limite_card.dart';

class CalendarioListaTarefas extends StatelessWidget {
  CalendarioListaTarefas({
    super.key,
    required this.tarefas,
    required this.dia,
    required this.largura,
    required this.altura,
  });

  final List<TarefaItem> tarefas;
  final DateTime dia;
  final double largura;
  final double altura;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final tarefasAgendadas = controlador.tarefasAgendadasDoDia(dia, tarefas);
    final tarefasComPrazo = controlador.tarefasComDataLimiteNoDia(dia, tarefas);
    final vazio = tarefasAgendadas.isEmpty && tarefasComPrazo.isEmpty;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        ),
        borderRadius: .circular(largura * 0.05),
      ),
      child: Padding(
        padding: .all(largura * 0.04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              controlador.formatarData(dia, true, true, false),
              style: TextStyle(fontSize: largura * 0.045, fontWeight: .w500),
            ),
            SizedBox(height: altura * 0.02),
            if (vazio)
              Padding(
                padding: .all(altura * 0.02),
                child: Center(
                  child: Text(
                    'Não existem tarefas neste dia.',
                    style: TextStyle(
                      fontSize: largura * 0.04,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            if (tarefasAgendadas.isNotEmpty) ...[
              Text(
                'Tarefas marcadas',
                style: TextStyle(
                  fontSize: largura * 0.04,
                  fontWeight: .w500,
                ),
              ),
              SizedBox(height: altura * 0.01),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tarefasAgendadas.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: altura * 0.005);
                },
                itemBuilder: (context, index) {
                  return TarefaCard(
                    tarefa: tarefasAgendadas[index],
                    largura: largura * 0.9,
                    altura: altura * 0.9,
                    iconTap: () {},
                    mostrarIcones: false,
                  );
                },
              ),
            ],
            if (tarefasAgendadas.isNotEmpty && tarefasComPrazo.isNotEmpty)
              SizedBox(height: altura * 0.025),
            if (tarefasComPrazo.isNotEmpty) ...[
              Text(
                'Datas limite',
                style: TextStyle(
                  fontSize: largura * 0.04,
                  fontWeight: .w500,
                ),
              ),
              SizedBox(height: altura * 0.01),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tarefasComPrazo.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: altura * 0.01);
                },
                itemBuilder: (context, index) {
                  return TarefaDataLimiteCard(
                    tarefa: tarefasComPrazo[index],
                    largura: largura,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
