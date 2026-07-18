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
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: SegmentedButton<FilterTarefa>(
        showSelectedIcon: false,
        segments: <ButtonSegment<FilterTarefa>>[
          ButtonSegment<FilterTarefa>(
            icon: Icon(
              Icons.list_alt_rounded,
              color: selecionado == .todos
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            value: .todos,
            label: Text(
              'Todos',
              style: TextStyle(
                fontSize: largura * 0.035,
                color: selecionado == .todos
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ButtonSegment<FilterTarefa>(
            value: .pendentes,
            icon: Icon(
              Icons.pending_actions_outlined,
              color: selecionado == .pendentes
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            label: Text(
              'Pendentes',
              style: TextStyle(
                fontSize: largura * 0.035,
                color: selecionado == .pendentes
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ButtonSegment<FilterTarefa>(
            value: .atrasados,
            icon: Icon(
              Icons.warning_amber_rounded,
              color: selecionado == .atrasados
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            label: Text(
              'Atrasados',
              style: TextStyle(
                fontSize: largura * 0.035,
                color: selecionado == .atrasados
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ButtonSegment<FilterTarefa>(
            value: .concluidos,
            icon: Icon(
              Icons.check_circle_outline_rounded,
              color: selecionado == .concluidos
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            label: Text(
              'Concluídos',
              style: TextStyle(
                fontSize: largura * 0.035,
                color: selecionado == .concluidos
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
        selected: {selecionado},
        onSelectionChanged: (novoSelecionado) {
          onChanged(novoSelecionado.first);
        },
      ),
    );
  }
}
