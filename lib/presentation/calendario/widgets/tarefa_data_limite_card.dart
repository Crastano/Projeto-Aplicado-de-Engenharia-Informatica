import 'package:flutter/material.dart';

import 'package:pei/controller/calendario_controlador.dart';
import 'package:pei/models/tarefa_item.dart';

class TarefaDataLimiteCard extends StatelessWidget {
  TarefaDataLimiteCard({
    super.key,
    required this.tarefa,
    required this.largura,
    this.compacto = false,
    this.onTap,
  }) : assert(tarefa.dataLimite != null);

  final TarefaItem tarefa;
  final double largura;
  final bool compacto;
  final VoidCallback? onTap;

  final CalendarioControlador controlador = CalendarioControlador();

  @override
  Widget build(BuildContext context) {
    final dataLimite = tarefa.dataLimite!;

    return Card.outlined(
      margin: .zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largura * 0.025),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: largura * 0.005,
        ),
      ),
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: .all(compacto ? largura * 0.015 : largura * 0.025),
          child: Row(
            children: [
              Container(
                width: compacto ? largura * 0.045 : largura * 0.09,
                height: compacto ? largura * 0.045 : largura * 0.09,
                decoration: BoxDecoration(
                  color: tarefa.categoryBackground,
                  shape: .circle,
                ),
                child: Icon(
                  Icons.flag_outlined,
                  color: tarefa.categoryText,
                  size: compacto ? largura * 0.035 : largura * 0.05,
                ),
              ),
              SizedBox(width: largura * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      tarefa.titulo,
                      maxLines: compacto ? 1 : 2,
                      overflow: .ellipsis,
                      style: TextStyle(
                        fontSize: compacto ? largura * 0.028 : largura * 0.04,
                        fontWeight: .w500,
                      ),
                    ),
                    SizedBox(height: largura * 0.005),
                    Text(
                      compacto
                          ? controlador.formatarHora(dataLimite)
                          : 'Data limite: '
                                '${controlador.formatarDataHora(dataLimite)}',
                      style: TextStyle(
                        fontSize: compacto ? largura * 0.025 : largura * 0.0325,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
