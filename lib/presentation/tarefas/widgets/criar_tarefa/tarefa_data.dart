import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

import 'package:pei/utils.dart';

class TarefaData extends StatefulWidget {
  const TarefaData({super.key, required this.largura});

  final double largura;

  @override
  State<TarefaData> createState() => _TarefaDataState();
}

class _TarefaDataState extends State<TarefaData> {
  final TarefasController controlador = TarefasController();

  DateTime dataSelecionada = DateTime.now();

  Future<void> selecionarData() async {
    final DateTime? dataEscolhido = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: kFirstDay,
      lastDate: kLastDay,
    );

    if (!mounted || dataEscolhido == null) return;

    setState(() {
      dataSelecionada = dataEscolhido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
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
              Theme.of(context).colorScheme.onSurface,
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: widget.largura * 0.005,
              ),
            ),
          ),
          child: Text(controlador.formatarData(dataSelecionada)),
        ),
      ],
    );
  }
}
