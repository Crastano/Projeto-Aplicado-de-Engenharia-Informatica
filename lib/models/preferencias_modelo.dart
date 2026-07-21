class PreferenciasModelo {
  const PreferenciasModelo({
    required this.tema,
    required this.idioma,
    required this.notificacoesAtivas,
    required this.lembretesTarefas,
    required this.tarefasAtrasadas,
    required this.somNotificacoes,
    required this.formato24Horas,
    required this.primeiroDiaSemana,
    required this.formatoData,
  });

  final String tema;
  final String idioma;
  final bool notificacoesAtivas;
  final bool lembretesTarefas;
  final bool tarefasAtrasadas;
  final bool somNotificacoes;
  final bool formato24Horas;
  final String primeiroDiaSemana;
  final String formatoData;
}