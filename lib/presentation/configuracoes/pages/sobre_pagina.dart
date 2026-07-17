import 'package:flutter/material.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double largura = constraints.maxWidth;
        final double altura = constraints.maxHeight;

        return PaginaConfiguracao(
          titulo: 'Sobre',
          children: [
            SizedBox(height: altura * 0.02),
            Center(
              child: SizedBox(
                width: largura * 0.5,
                height: largura * 0.5,
                child: Image.asset('assets/images/logo.png', fit: .contain),
              ),
            ),
            SizedBox(height: altura * 0.025),
            Text(
              'Projeto Aplicado de Engenharia Informática',
              textAlign: .center,
              style: TextStyle(fontWeight: .w600, fontSize: largura * 0.05),
            ),
            SizedBox(height: altura * 0.01),
            Text(
              'App de responsabilidades do dia a dia',
              textAlign: .center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: largura * 0.04,
              ),
            ),
            SizedBox(height: altura * 0.01),
            Text(
              'Versão 1.0.0',
              textAlign: .center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: largura * 0.035,
              ),
            ),
            SizedBox(height: altura * 0.04),
            TituloSecao(texto: 'Informações', largura: largura),
            CardConfiguracao(
              largura: largura,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.description_outlined,
                    size: largura * 0.06,
                  ),
                  title: Text(
                    'Termos de utilização',
                    style: TextStyle(fontSize: largura * 0.04),
                  ),
                  trailing: Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    size: largura * 0.06,
                  ),
                  title: Text(
                    'Política de privacidade',
                    style: TextStyle(fontSize: largura * 0.04),
                  ),
                  trailing: Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.code_rounded, size: largura * 0.06),
                  title: Text(
                    'Licenças de código aberto',
                    style: TextStyle(fontSize: largura * 0.04),
                  ),
                  trailing: Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: 'App de Responsabilidades',
                      applicationVersion: '1.0.0',
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
