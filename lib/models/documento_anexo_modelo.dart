class DocumentoAnexoModelo {
  const DocumentoAnexoModelo({
    required this.id,
    required this.tarefaId,
    required this.nomeFicheiro,
    required this.uri,
  });

  final int id;
  final String tarefaId;
  final String nomeFicheiro;
  final String uri;
}
