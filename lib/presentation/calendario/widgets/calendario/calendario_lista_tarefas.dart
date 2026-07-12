import 'package:flutter/material.dart';

// Modelos
import 'package:pei/models/tarefaItem.dart';

// Widgets partilhados
import 'package:pei/presentation/shared/widgets/tarefa_card.dart';

// Controladores
import 'package:pei/controller/calendario_controller.dart';

// ignore: must_be_immutable
class CalendarioListaTarefas extends StatefulWidget {
  const CalendarioListaTarefas({
    super.key,
    required this.tarefasSelecionados,
    required this.largura,
    required this.altura,
    required this._focusedDay,
    required this._selectedDay,
  });

  final ValueNotifier<List<TarefaItem>> tarefasSelecionados;
  final double largura;
  final double altura;
  final DateTime _focusedDay;
  final DateTime? _selectedDay;

  @override
  State<CalendarioListaTarefas> createState() => _CalendarioListaTarefasState();
}

class _CalendarioListaTarefasState extends State<CalendarioListaTarefas> {
  final CalendarioController controlador = CalendarioController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TarefaItem>>(
      valueListenable: widget.tarefasSelecionados,
      builder: (context, tarefas, _) {
        return Container(
          width: .infinity,
          padding: .all(widget.largura * 0.025),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: .circular(widget.largura * 0.05),
            border: .all(
              color: Theme.of(context).colorScheme.outline,
              width: widget.largura * 0.005,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.3),
                offset: Offset(0, widget.altura * 0.003),
                blurRadius: widget.largura * 0.005,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: widget.altura * 0.01),

              Text(
                controlador.formatarData(
                  widget._selectedDay ?? widget._focusedDay,
                  true,
                  true,
                ),
                style: TextStyle(
                  fontSize: widget.largura * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: widget.altura * 0.02),

              if (tarefas.isEmpty)
                Padding(
                  padding: .symmetric(vertical: widget.altura * 0.02),
                  child: Center(
                    child: Text(
                      'Não existem tarefas neste dia.',
                      style: TextStyle(fontSize: widget.largura * 0.04),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tarefas.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: widget.altura * 0.01);
                  },
                  itemBuilder: (context, index) {
                    return TarefaCard(
                      tarefa: tarefas[index],
                      largura: widget.largura * 0.9,
                      altura: widget.altura * 0.9,
                      iconTap: () {},
                      cardTap: () {},
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
