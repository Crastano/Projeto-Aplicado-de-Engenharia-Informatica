import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

class NotificacoesPage extends StatelessWidget {
  NotificacoesPage({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        return PaginaConfiguracao(
          titulo: 'Notificações',
          children: [
            AnimatedBuilder(
              animation: controlador,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: .start,
                  children: [
                    TituloSecao(texto: 'Geral', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        SwitchListTile(
                          secondary: Icon(
                            Icons.notifications_outlined,
                            size: largura * 0.06,
                          ),
                          title: Text(
                            'Ativar notificações',
                            style: TextStyle(fontSize: largura * 0.04),
                          ),
                          subtitle: Text(
                            'Permitir notificações da aplicação',
                            style: TextStyle(fontSize: largura * 0.035),
                          ),
                          value: controlador.notificacoesAtivas,
                          onChanged: controlador.alterarNotificacoesAtivas,
                        ),
                      ],
                    ),
                    SizedBox(height: altura * 0.025),
                    TituloSecao(texto: 'Tarefas', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        SwitchListTile(
                          secondary: Icon(
                            Icons.alarm_outlined,
                            size: largura * 0.06,
                          ),
                          title: Text(
                            'Lembretes das tarefas',
                            style: TextStyle(fontSize: largura * 0.04),
                          ),
                          subtitle: Text(
                            'Avisar antes da hora definida',
                            style: TextStyle(fontSize: largura * 0.035),
                          ),
                          value: controlador.lembretesTarefas,
                          onChanged: controlador.notificacoesAtivas
                              ? controlador.alterarLembretesTarefas
                              : null,
                        ),
                        Divider(height: 1),
                        SwitchListTile(
                          secondary: Icon(
                            Icons.warning_amber_rounded,
                            size: largura * 0.06,
                          ),
                          title: Text(
                            'Tarefas atrasadas',
                            style: TextStyle(fontSize: largura * 0.04),
                          ),
                          subtitle: Text(
                            'Avisar quando uma tarefa ultrapassar o prazo',
                            style: TextStyle(fontSize: largura * 0.035),
                          ),
                          value: controlador.tarefasAtrasadas,
                          onChanged: controlador.notificacoesAtivas
                              ? controlador.alterarTarefasAtrasadas
                              : null,
                        ),
                        Divider(height: 1),
                      ],
                    ),
                    SizedBox(height: altura * 0.025),
                    TituloSecao(texto: 'Som', largura: largura),
                    CardConfiguracao(
                      largura: largura,
                      children: [
                        SwitchListTile(
                          secondary: Icon(
                            Icons.volume_up_outlined,
                            size: largura * 0.06,
                          ),
                          title: Text(
                            'Som das notificações',
                            style: TextStyle(fontSize: largura * 0.04),
                          ),
                          value: controlador.somNotificacoes,
                          onChanged: controlador.notificacoesAtivas
                              ? controlador.alterarSomNotificacoes
                              : null,
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
