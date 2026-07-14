import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controller.dart';

class TarefaDataLimite extends StatefulWidget {
  const TarefaDataLimite({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaDataLimite> createState() => _TarefaDataLimiteState();
}

class _TarefaDataLimiteState extends State<TarefaDataLimite> {
  final TarefasControlador controlador = TarefasControlador();

  DateTime? dataSelecionada;

  Future<void> selecionarData() async {
    final DateTime? dataEscolhido = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Selecionar data limite',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );

    if (!mounted || dataEscolhido == null) return;

    setState(() {
      dataSelecionada = dataEscolhido;
    });
  }

  void removerData() {
    setState(() {
      dataSelecionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Row(
          children: [
            Icon(Icons.event_busy_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Data Limite',
              style: TextStyle(
                fontWeight: .w500,
                fontSize: widget.largura * 0.045,
              ),
            ),
          ],
        ),
        Spacer(),
        OutlinedButton(
          onPressed: selecionarData,
          onLongPress: dataSelecionada == null ? null : removerData,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
            foregroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: widget.largura * 0.005,
              ),
            ),
          ),
          child: Text(
            dataSelecionada == null
                ? 'Adicionar'
                : controlador.formatarData(dataSelecionada!),
            ),
          ),
      ],
    );
  }
}
