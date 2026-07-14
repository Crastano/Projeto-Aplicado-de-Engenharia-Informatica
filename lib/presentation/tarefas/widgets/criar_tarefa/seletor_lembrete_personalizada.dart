import 'package:flutter/material.dart';

// Controlador
import 'package:pei/controller/tarefas_controller.dart';

// Enums
import 'package:pei/enums/unidade_lembrete.dart';

class SeletorLembretePersonalizado extends StatefulWidget {
  const SeletorLembretePersonalizado({
    super.key,
    required this.largura,
    required this.configuracaoInicial,
  });

  final double largura;
  final ConfiguracaoLembrete configuracaoInicial;

  @override
  State<SeletorLembretePersonalizado> createState() =>
      _SeletorLembretePersonalizadoState();
}

class _SeletorLembretePersonalizadoState
    extends State<SeletorLembretePersonalizado> {
  final TarefasControlador controlador = TarefasControlador();

  late int quantidade;
  late UnidadeLembrete unidade;

  @override
  void initState() {
    super.initState();

    quantidade = widget.configuracaoInicial.quantidade;
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
              'Lembrete personalizado',
              style: TextStyle(
                fontSize: widget.largura * 0.055,
                fontWeight: .w600,
              ),
            ),
            SizedBox(height: widget.largura * 0.025),
            Text(
              'Receber o lembrete antes da tarefa:',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: widget.largura * 0.06),
            Row(
              children: [
                IconButton.outlined(
                  onPressed: quantidade > 1
                      ? () {
                          setState(() {
                            quantidade--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove),
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
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(widget.largura * 0.025),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    ),
                  ),
                  child: Text(
                    '$quantidade',
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
                      quantidade++;
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
                  child: DropdownButtonFormField<UnidadeLembrete>(
                    initialValue: unidade,
                    isExpanded: true,
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
                    items: UnidadeLembrete.values.map((item) {
                      return DropdownMenuItem<UnidadeLembrete>(
                        value: item,
                        child: Text(
                          controlador.formatarUnidadeLembrete(item, quantidade),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (novaUnidade) {
                      if (novaUnidade == null) return;

                      setState(() {
                        unidade = novaUnidade;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.largura * 0.06),
            SizedBox(
              width: .infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    ConfiguracaoLembrete(
                      quantidade: quantidade,
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
