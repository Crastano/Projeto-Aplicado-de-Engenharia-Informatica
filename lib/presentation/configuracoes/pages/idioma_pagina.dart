import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

// Modelos
import 'package:pei/models/idioma_item.dart';

class IdiomaPage extends StatelessWidget {
  IdiomaPage({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

  final List<IdiomaItem> idiomas = const [
    IdiomaItem(nome: 'Português', bandeira: '🇵🇹'),
    IdiomaItem(nome: 'English', bandeira: '🇬🇧'),
    IdiomaItem(nome: 'Español', bandeira: '🇪🇸'),
    IdiomaItem(nome: 'Français', bandeira: '🇫🇷'),
    IdiomaItem(nome: 'Deutsch', bandeira: '🇩🇪'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;

        return PaginaConfiguracao(
          titulo: 'Idioma',
          children: [
            TituloSecao(texto: 'Idioma da aplicação', largura: largura),
            AnimatedBuilder(
              animation: controlador,
              builder: (context, child) {
                return RadioGroup(
                  onChanged: (String? value) {
                    if (value == null) return;

                    controlador.alterarIdioma(value);
                  },
                  groupValue: controlador.idioma,
                  child: CardConfiguracao(
                    largura: largura,
                    children: [
                      for (int index = 0; index < idiomas.length; index++) ...[
                        RadioListTile(
                          value: idiomas[index].nome,
                          secondary: Text(
                            idiomas[index].bandeira,
                            style: TextStyle(fontSize: largura * 0.06),
                          ),
                          title: Text(
                            idiomas[index].nome,
                            style: TextStyle(fontSize: largura * 0.045),
                          ),
                        ),

                        if (index != idiomas.length - 1) Divider(height: 1,),
                      ],
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Text(
              'Algumas alterações de idioma podem precisar de reiniciar a aplicação.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      },
    );
  }
}
