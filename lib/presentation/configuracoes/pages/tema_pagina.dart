import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';

// Widgets
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

class TemaPagina extends StatelessWidget {
  TemaPagina({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;

        return PaginaConfiguracao(
          titulo: 'Tema',
          children: [
            TituloSecao(texto: 'Aparência', largura: largura),

            AnimatedBuilder(
              animation: controlador,
              builder: (context, child) {
                return RadioGroup(
                  onChanged: (value) {
                    if (value == null) return;

                    controlador.alterarTema(value);
                  },
                  groupValue: controlador.tema,
                  child: CardConfiguracao(
                    largura: largura,
                    children: [
                      RadioListTile<ThemeMode>(
                        value: .light,
                        title: Text(
                          'Claro',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: largura * 0.04,
                          ),
                        ),
                        subtitle: Text(
                          'Usar sempre o tema claro',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: largura * 0.035,
                          ),
                        ),
                        secondary: Icon(
                          Icons.light_mode_outlined,
                          size: largura * 0.06,
                        ),
                      ),
                      Divider(height: 1),
                      RadioListTile<ThemeMode>(
                        value: .dark,
                        title: Text(
                          'Escuro',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: largura * 0.04,
                          ),
                        ),
                        subtitle: Text(
                          'Usar sempre o tema escuro',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: largura * 0.035,
                          ),
                        ),
                        secondary: Icon(
                          Icons.dark_mode_outlined,
                          size: largura * 0.06,
                        ),
                      ),
                      Divider(height: 1),
                      RadioListTile<ThemeMode>(
                        value: .system,
                        title: Text(
                          'Sistema',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: largura * 0.04,
                          ),
                        ),
                        subtitle: Text(
                          'Seguir o tema definido no dispositivo',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: largura * 0.035,
                          ),
                        ),
                        secondary: Icon(
                          Icons.settings_brightness_outlined,
                          size: largura * 0.06,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
