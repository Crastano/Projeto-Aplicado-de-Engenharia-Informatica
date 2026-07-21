import 'package:flutter/material.dart';

// Controladores
import 'package:pei/controller/configuracoes_controlador.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

// Modelos
import 'package:pei/models/idioma_modelo.dart';

class IdiomaPagina extends StatelessWidget {
  IdiomaPagina({super.key});

  final ConfiguracoesControlador controlador =
      ConfiguracoesControlador.instancia;

  final List<IdiomaModelo> idiomas = const [
    IdiomaModelo(nome: 'Português', bandeira: '🇵🇹'),
    IdiomaModelo(nome: 'English', bandeira: '🇬🇧'),
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
                        RadioListTile<String>(
                          value: idiomas[index].nome,
                          enabled: idiomas[index].nome == 'Português',
                          secondary: Text(
                            idiomas[index].bandeira,
                            style: TextStyle(fontSize: largura * 0.06),
                          ),
                          title: Text(
                            idiomas[index].nome,
                            style: TextStyle(fontSize: largura * 0.045),
                          ),
                          subtitle: idiomas[index].nome == 'Português'
                              ? null
                              : Text('Tradução ainda não implementada'),
                        ),

                        if (index != idiomas.length - 1) Divider(height: 1),
                      ],
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
