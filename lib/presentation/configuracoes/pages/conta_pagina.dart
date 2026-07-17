import 'package:flutter/material.dart';

// Widgets
import 'package:pei/presentation/configuracoes/widgets/pagina_configuracao.dart';
import '../widgets/titulo_secao.dart';
import '../widgets/card_configuracao.dart';

class ContaPage extends StatelessWidget {
  const ContaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;

        return PaginaConfiguracao(
          titulo: 'Conta',
          children: [
            Center(
              child: Container(
                width: largura * 0.3,
                height: largura * 0.3,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: largura * 0.15,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(height: altura * 0.05),
            Text(
              'Não tens sessão iniciada',
              textAlign: .center,
              style: TextStyle(fontWeight: .w500, fontSize: largura * 0.06),
            ),
            SizedBox(height: altura * 0.015),
            Text(
              'Inicia sessão para sincronizar as tuas tarefas e configurações entre dispositivos.',
              textAlign: .center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: largura * 0.04,
              ),
            ),
            SizedBox(height: altura * 0.035),
            SizedBox(
              width: .infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.login_rounded, size: largura * 0.06,),
                label: Text(
                  'Iniciar sessão com Google',
                  style: TextStyle(fontSize: largura * 0.035),
                ),
              ),
            ),
            SizedBox(height: altura * 0.025),
            TituloSecao(texto: 'Dados', largura: largura),
            CardConfiguracao(
              largura: largura,
              children: [
                ListTile(
                  leading: Icon(Icons.cloud_outlined),
                  title: Text('Sincronização', style: TextStyle(
                    fontSize: largura * 0.04
                  )),
                  subtitle: Text('Não disponível sem conta', style: TextStyle(
                    fontSize: largura * 0.035
                  ),),
                  enabled: false,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
