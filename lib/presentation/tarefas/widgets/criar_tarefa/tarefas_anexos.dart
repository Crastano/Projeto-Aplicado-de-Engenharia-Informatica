import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

// Widgets
import 'pagina_anexos.dart';

class TarefaAnexos extends StatelessWidget {
  const TarefaAnexos({
    super.key,
    required this.controlador,
    required this.largura,
  });

  final TarefasControlador controlador;
  final double largura;

  Future<void> abrirPaginaAnexos(BuildContext context) async {
    final resultado = await Navigator.push<List<PlatformFile>>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaginaAnexos(
            controlador: controlador,
            largura: largura,
            anexosIniciais: controlador.anexos,
          );
        },
      ),
    );

    if (resultado != null) controlador.atualizarAnexos(resultado);
  }

  Future<void> abrirAnexo(BuildContext context, PlatformFile anexo) async {
    final String? caminho = anexo.path;

    if (caminho == null || caminho.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível encontrar o ficheiro.')),
      );
      return;
    }

    final OpenResult resultado = await OpenFilex.open(caminho);

    if (!context.mounted || resultado.type == ResultType.done) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(controlador.mensagemAnexo(resultado))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) {
        final anexos = controlador.anexos;

        return Padding(
          padding: .symmetric(vertical: largura * 0.012),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.attach_file_outlined, size: largura * 0.075),
                  SizedBox(width: largura * 0.04),
                  Expanded(
                    child: Text(
                      'Anexos',
                      style: TextStyle(
                        fontWeight: .w500,
                        fontSize: largura * 0.045,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => abrirPaginaAnexos(context),
                    child: Text(
                      anexos.isEmpty ? 'Adicionar' : 'Editar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: .w500,
                        fontSize: largura * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
              if (anexos.isNotEmpty) ...[
                SizedBox(height: largura * 0.02),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: anexos.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: largura * 0.01);
                  },
                  itemBuilder: (context, index) {
                    final anexo = anexos[index];

                    return Card(
                      margin: .zero,
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(largura * 0.025),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: largura * 0.005,
                        ),
                      ),
                      child: ListTile(
                        onTap: () => abrirAnexo(context, anexo),
                        leading: Icon(
                          controlador.obterIconeAnexos(anexo.extension),
                        ),
                        title: Text(
                          controlador.obterNomeSemExtensao(anexo),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                        subtitle: Text(
                          anexo.extension?.toUpperCase() ?? 'FICHEIRO',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
