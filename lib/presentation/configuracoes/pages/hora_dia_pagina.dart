import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';
import 'package:pei/utils/formatador_data_hora.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

class HoraDiaPagina extends StatelessWidget {
  HoraDiaPagina({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

  final List<String> diasSemana = const ['Segunda-feira', 'Domingo'];

  final List<String> formatosData = const [
    'dd/MM/yyyy',
    'dd-MM-yyyy',
    'yyyy-MM-dd',
    'MM/dd/yyyy',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        return PaginaConfiguracao(
          titulo: 'Hora e dia',
          children: [
            AnimatedBuilder(
              animation: controlador,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: .start,
                  children: [
                    TituloSecao(texto: 'Hora', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        SwitchListTile(
                          title: Text('Formato de 24 horas', style: TextStyle(fontSize: largura * 0.04),),
                          secondary: Icon(Icons.schedule_outlined, size: largura * 0.06,),
                          subtitle: Text(
                            controlador.formato24Horas
                                ? 'Exemplo: 18:30'
                                : 'Exemplo: 6:30 PM',
                                style: TextStyle(fontSize: largura * 0.035),
                          ),
                          value: controlador.formato24Horas,
                          onChanged: controlador.alterarFormato24Horas,
                        ),
                      ],
                    ),
                    SizedBox(height: altura * 0.025),
                    TituloSecao(texto: 'Calendário', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        Padding(
                          padding: .all(largura * 0.04),
                          child: DropdownButtonFormField<String>(
                            initialValue: controlador.primeiroDiaSemana,
                            decoration: InputDecoration(
                              labelText: 'Primeiro dia da semana',
                              prefixIcon: Icon(
                                Icons.calendar_view_week_outlined,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: largura * 0.005,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: largura * 0.005,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: largura * 0.005,
                                ),
                              ),
                            ),
                            items: diasSemana.map((dia) {
                              return DropdownMenuItem<String>(
                                value: dia,
                                child: Text(dia),
                              );
                            }).toList(),
                            onChanged: (valor) {
                              if (valor == null) return;

                              controlador.alterarPrimeiroDiaSemana(valor);
                            },
                          ),
                        ),
                        Divider(height: 1,),
                        Padding(
                          padding: .all(largura * 0.04),
                          child: DropdownButtonFormField<String>(
                            initialValue: controlador.formatoData,
                            decoration: InputDecoration(
                              labelText: 'Formato da data',
                              prefixIcon: Icon(Icons.date_range_outlined),
                              border: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: largura * 0.005,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: largura * 0.005,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: .circular(largura * 0.025),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: largura * 0.005,
                                ),
                              ),
                            ),
                            items: formatosData.map((formato) {
                              return DropdownMenuItem<String>(
                                value: formato,
                                child: Text(formato),
                              );
                            }).toList(),
                            onChanged: (valor) {
                              if (valor == null) return;

                              controlador.alterarFormatoData(valor);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: altura * 0.025),
                    TituloSecao(texto: 'Exemplo', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        ListTile(
                          leading: Icon(Icons.event_outlined),
                          title: Text('Data e hora', style: TextStyle(
                            fontSize: largura * 0.04,
                          )),
                          subtitle: Text(
                            FormatadorDataHora.dataHora(DateTime.now()),
                                style: TextStyle(fontSize: largura * 0.035),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
