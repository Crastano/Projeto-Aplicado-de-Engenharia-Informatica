import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

// Controlador
import 'package:pei/controller/tarefas_controlador.dart';

class PaginaAnexos extends StatefulWidget {
  const PaginaAnexos({
    super.key,
    required this.largura,
    required this.anexosIniciais,
  });

  final double largura;
  final List<PlatformFile> anexosIniciais;

  @override
  State<PaginaAnexos> createState() => _PaginaAnexosState();
}

class _PaginaAnexosState extends State<PaginaAnexos> {
  final TarefasControlador controlador = TarefasControlador();

  late List<PlatformFile> anexos = List<PlatformFile>.from(
    widget.anexosIniciais,
  );

  Future<void> adicionarAnexos() async {
    final FilePickerResult? resultado = await FilePicker.pickFiles(type: FileType.any);

    if (!mounted || resultado == null) return;

    final Set<String> anexosExistentes = anexos
        .map((anexo) => '${anexo.name}-${anexo.size}')
        .toSet();

    setState(() {
      for (final ficheiro in resultado.files) {
        final String nome = '${ficheiro.name}-${ficheiro.size}';

        if (anexosExistentes.add(nome)) {
          anexos.add(ficheiro);
        }
      }
    });
  }

  void removerAnexo(int index) {
    setState(() {
      anexos.removeAt(index);
    });
  }

  Future<void> abrirAnexo(PlatformFile anexo) async {
    final String? caminho = anexo.path;

    if (caminho == null || caminho.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível encontrar o ficheiro.')),
      );

      return;
    }

    final OpenResult resultado = await OpenFilex.open(caminho);

    if (!mounted || resultado.type == .done) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(controlador.mensagemAnexo(resultado))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anexos'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, List<PlatformFile>.from(anexos));
          },
          icon: Icon(Icons.chevron_left_outlined, size: widget.largura * 0.075),
        ),
        actions: [
          TextButton(
            onPressed: adicionarAnexos,
            child: Text(
              'Adicionar',
              style: TextStyle(
                fontSize: widget.largura * 0.035,
                fontWeight: .w500,
              ),
            ),
          ),
        ],
      ),
      body: anexos.isEmpty
          ? Center(
              child: TextButton.icon(
                onPressed: adicionarAnexos,
                icon: Icon(Icons.attach_file_outlined),
                label: Text(
                  'Adicionar anexo',
                  style: TextStyle(
                    fontSize: widget.largura * 0.05,
                    fontWeight: .w500,
                  ),
                ),
              ),
            )
          : ListView.separated(
              padding: .all(widget.largura * 0.06),
              itemCount: anexos.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: widget.largura * 0.025);
              },
              itemBuilder: (context, index) {
                final anexo = anexos[index];

                return Card(
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(widget.largura * 0.025),
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
                    trailing: IconButton(
                      onPressed: () {
                        removerAnexo(index);
                      },
                      color: Theme.of(context).colorScheme.onError,
                      icon: Icon(Icons.delete_outline),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
