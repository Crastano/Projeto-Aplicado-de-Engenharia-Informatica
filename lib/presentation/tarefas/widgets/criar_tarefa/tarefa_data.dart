import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

class TarefaData extends StatefulWidget {
  const TarefaData({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaData> createState() => _TarefaDataState();
}

class _TarefaDataState extends State<TarefaData> {
  final TarefasControlador controlador = TarefasControlador();

  DateTime dataSelecionada = DateTime.now();

  Future<void> selecionarData() async {
    final DateTime? dataEscolhido = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Selecionar data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );

    if (!mounted || dataEscolhido == null) return;

    setState(() {
      dataSelecionada = dataEscolhido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Data',
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
            controlador.formatarData(dataSelecionada),
          ),
        ),
      ],
    );
  }
}
