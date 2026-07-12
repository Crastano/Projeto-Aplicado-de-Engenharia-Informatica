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
    return SegmentedButton<FilterTarefa>(
      showSelectedIcon: false,
      segments: <ButtonSegment<FilterTarefa>>[
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.todos,
          label: Text(
            'Todos',
            style: TextStyle(fontSize: widget.largura * 0.04),
          ),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.pendentes,
          label: Text(
            'Pendentes',
            style: TextStyle(fontSize: widget.largura * 0.04),
          ),
        ),
        ButtonSegment<FilterTarefa>(
          value: FilterTarefa.concluidos,
          label: Text(
            'Concluídos',
            style: TextStyle(fontSize: widget.largura * 0.04),
          ),
        ),
      ],
      selected: {widget.selecionado},
      onSelectionChanged: (novoSelecionado) {
        widget.onChanged(novoSelecionado.first);
      },
    );
  }
}
