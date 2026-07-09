import 'package:flutter/material.dart';
import 'package:pei/controller/home_controller.dart';

class SelecionarFilter extends StatefulWidget {
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
  State<SelecionarFilter> createState() => _SelecionarFilterState();
}

class _SelecionarFilterState extends State<SelecionarFilter> {
  @override
  Widget build(BuildContext context) {
    final double fontSize = widget.largura * 0.032;
    final double iconSize = widget.largura * 0.045;

    Text label(String texto) {
      return Text(
        texto,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: TextStyle(fontSize: fontSize),
      );
    }

    return SegmentedButton<FilterTarefa>(
      showSelectedIcon: false,
      segments: <ButtonSegment<FilterTarefa>>[
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.todos,
          label: label('Todos'),
          icon: Icon(Icons.list_alt_rounded, size: iconSize),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.pendentes,
          label: label('Pendentes'),
          icon: Icon(Icons.pending_actions_rounded, size: iconSize),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.concluidos,
          label: label('Concluídos'),
          icon: Icon(Icons.task_alt_rounded, size: iconSize),
        ),
      ],
      selected: {widget.selecionado},
      onSelectionChanged: (Set<FilterTarefa> novoSelecionado) {
        widget.onChanged(novoSelecionado.first);
      },
    );
  }
}