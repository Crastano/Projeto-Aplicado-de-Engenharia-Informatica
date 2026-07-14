import 'package:flutter/material.dart';

// Enums
import 'package:pei/enums/filter_tarefa.dart';

class SelecionarFilter extends StatelessWidget {
  const SelecionarFilter({
    super.key,
    required this.largura,
    required this.selecionado,
    required this.onChanged,
  });

  final double largura;
  final FilterTarefa selecionado;
  final ValueChanged<FilterTarefa> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FilterTarefa>(
      showSelectedIcon: false,
      segments: <ButtonSegment<FilterTarefa>>[
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.todos,
          label: Text('Todos', style: TextStyle(fontSize: largura * 0.03)),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.pendentes,
          label: Text('Pendentes', style: TextStyle(fontSize: largura * 0.03)),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.atrasados,
          label: Text('Atrasados', style: TextStyle(fontSize: largura * 0.03)),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.concluidos,
          label: Text('Concluídos', style: TextStyle(fontSize: largura * 0.03)),
        ),
      ],
      selected: {selecionado},
      onSelectionChanged: (novoSelecionado) {
        onChanged(novoSelecionado.first);
      },
    );
  }
}
