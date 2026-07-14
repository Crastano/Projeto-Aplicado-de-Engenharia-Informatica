import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

// Controlador
import 'package:pei/controller/tarefas_controller.dart';

// Widgets
import 'pagina_anexos.dart';

class TarefaAnexos extends StatefulWidget {
  const TarefaAnexos({
    super.key,
    required this.largura,
    this.anexosIniciais = const [],
  });

  final double largura;
  final List<PlatformFile> anexosIniciais;

  @override
  State<TarefaAnexos> createState() => _TarefaAnexosState();
}

class _TarefaAnexosState extends State<TarefaAnexos> {
  final TarefasControlador controlador = TarefasControlador();

  late List<PlatformFile> anexos = List<PlatformFile>.from(
    widget.anexosIniciais,
  );

  Future<void> abrirPaginaAnexos() async {
    final resultado = await Navigator.push<List<PlatformFile>>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaginaAnexos(largura: widget.largura, anexosIniciais: anexos);
        },
      ),
    );

    if (!mounted || resultado == null) return;

    setState(() {
      anexos = resultado;
    });
  }

  Future<void> abrirAnexo(PlatformFile anexo) async {
    final caminho = anexo.path;

    if (caminho == null || caminho.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível encontrar o ficheiro.')),
      );

      return;
    }

    final resultado = await OpenFilex.open(caminho);

    if (!mounted || resultado.type == ResultType.done) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(controlador.mensagemAnexo(resultado))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.attach_file_outlined, size: widget.largura * 0.09),
            SizedBox(width: widget.largura * 0.05),
            Text(
              'Anexos',
              style: TextStyle(
                fontWeight: .w500,
                fontSize: widget.largura * 0.045,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: abrirPaginaAnexos,
              child: Text(
                anexos.isEmpty ? 'Adicionar' : 'Editar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: .w500,
                  fontSize: widget.largura * 0.04,
                ),
              ),
            ),
          ],
        ),

        if (anexos.isNotEmpty) ...[
          SizedBox(height: widget.largura * 0.025),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: anexos.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: widget.largura * 0.01);
            },
            itemBuilder: (context, index) {
              final anexo = anexos[index];

              return Card(
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.largura * 0.025),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: widget.largura * 0.005,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      abrirAnexo(anexo);
                    },
                    leading: Icon(
                      controlador.obterIconeAnexos(anexo.extension),
                      size: widget.largura * 0.075,
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
    );
  }
}
