import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/tarefas_controller.dart';

class SeletorPeriodicidadePersonalizada extends StatefulWidget {
  const SeletorPeriodicidadePersonalizada({
    super.key,
    required this.largura,
    required this.configuracaoInicial,
  });

  final double largura;
  final ConfiguracaoPeriodicidade configuracaoInicial;

  @override
  State<SeletorPeriodicidadePersonalizada> createState() =>
      _SeletorPeriodicidadePersonalizadaState();
}

class _SeletorPeriodicidadePersonalizadaState
    extends State<SeletorPeriodicidadePersonalizada> {
  final TarefasController controlador = TarefasController();

  late int intervalo;
  late UnidadePeriodicidade unidade;

  @override
  void initState() {
    super.initState();

    intervalo = widget.configuracaoInicial.intervalo;
    unidade = widget.configuracaoInicial.unidade;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: .all(widget.largura * 0.06),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              'Periodicidade personalizada',
              style: TextStyle(
                fontSize: widget.largura * 0.055,
                fontWeight: .w600,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Repetir a tarefa a cada:',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Row(
              children: [
                IconButton.outlined(
                  onPressed: intervalo > 1
                      ? () {
                          setState(() {
                            intervalo--;
                          });
                        }
                      : null,
                  icon: Icon(Icons.remove),
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: widget.largura * 0.005,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widget.largura * 0.025),
                Container(
                  width: widget.largura * 0.15,
                  padding: EdgeInsets.symmetric(
                    vertical: widget.largura * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(widget.largura * 0.025),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    ),
                  ),
                  child: Text(
                    '$intervalo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.largura * 0.05,
                      fontWeight: .w500,
                    ),
                  ),
                ),
                SizedBox(width: widget.largura * 0.025),
                IconButton.outlined(
                  onPressed: () {
                    setState(() {
                      intervalo++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: widget.largura * 0.005,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widget.largura * 0.04),
                Expanded(
                  child: DropdownButtonFormField<UnidadePeriodicidade>(
                    initialValue: unidade,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.largura * 0.025,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: widget.largura * 0.005,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.largura * 0.025,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: widget.largura * 0.005,
                        ),
                      ),
                    ),
                    items: UnidadePeriodicidade.values.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          controlador.formatarUnidadePeriodicidade(item, intervalo),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        unidade = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.largura * 0.06),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    ConfiguracaoPeriodicidade(
                      intervalo: intervalo,
                      unidade: unidade,
                    ),
                  );
                },
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
