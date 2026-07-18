import 'package:flutter/material.dart';

// Controlaodr
import 'package:pei/controller/tarefas_controlador.dart';

// Enums
import 'package:pei/enums/unidade_lembrete.dart';

class SeletorLembretePersonalizado extends StatefulWidget {
  const SeletorLembretePersonalizado({
    super.key,
    required this.controlador,
    required this.largura,
    required this.configuracaoInicial,
  });

  final TarefasControlador controlador;
  final double largura;
  final ConfiguracaoLembrete configuracaoInicial;

  @override
  State<SeletorLembretePersonalizado> createState() =>
      _SeletorLembretePersonalizadoState();
}

class _SeletorLembretePersonalizadoState
    extends State<SeletorLembretePersonalizado> {
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
                fontSize: widget.largura * 0.06,
                fontWeight: .w500,
              ),
            ),
            SizedBox(height: widget.largura * 0.015),
            Text(
              'Avisar antes da tarefa:',
              style: TextStyle(
                fontSize: widget.largura * 0.04,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: widget.largura * 0.05),
            Row(
              children: [
                IconButton.outlined(
                  onPressed: quantidade > 1
                      ? () {
                          setState(() => quantidade--);
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
                  padding: .symmetric(vertical: widget.largura * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: .circular(widget.largura * 0.025),
                    border: .all(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    ),
                  ),
                  child: Text(
                    '$quantidade',
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: widget.largura * 0.05,
                      fontWeight: .w500,
                    ),
                  ),
                ),
                SizedBox(width: widget.largura * 0.025),
                IconButton.outlined(
                  onPressed: () => setState(() => quantidade++),
                  icon: Icon(Icons.add),
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
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          widget.controlador.formatarUnidadeLembrete(
                            item,
                            quantidade,
                          ),
                          overflow: .ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => unidade = value);
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
                child: Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
