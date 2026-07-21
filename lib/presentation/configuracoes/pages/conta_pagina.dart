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
          titulo: 'Conta local',
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
              'Utilizador local',
              textAlign: .center,
              style: TextStyle(fontWeight: .w500, fontSize: largura * 0.06),
            ),
            SizedBox(height: altura * 0.015),
            Text(
              'As tarefas, categorias e preferências ficam guardadas apenas neste dispositivo através de SQLite.',
              textAlign: .center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: largura * 0.04,
              ),
            ),
            SizedBox(height: altura * 0.035),
            TituloSecao(texto: 'Armazenamento', largura: largura),
            CardConfiguracao(
              largura: largura,
              children: [
                ListTile(
                  leading: Icon(Icons.storage_rounded),
                  title: Text(
                    'Base de dados SQLite',
                    style: TextStyle(fontSize: largura * 0.04),
                  ),
                  subtitle: Text(
                    'Dados locais, sem sincronização na cloud',
                    style: TextStyle(fontSize: largura * 0.035),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
