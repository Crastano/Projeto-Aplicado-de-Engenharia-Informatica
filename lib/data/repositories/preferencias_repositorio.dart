import '../database/base_de_dados.dart';

// Modelos
import 'package:pei/models/preferencias_modelo.dart';

class PreferenciasRepositorio {
  Future<PreferenciasModelo> obter() async {
    final db = await AppDatabase.instancia.database;
    final linhas = await db.query(
      'preferencias',
      where: 'utilizador_id = ?',
      whereArgs: [AppDatabase.utilizadorLocalId],
      limit: 1,
    );

    if (linhas.isEmpty) {
      throw StateError('As preferências do utilizador local não existem.');
    }

    final linha = linhas.first;
    return PreferenciasModelo(
      tema: linha['tema']! as String,
      idioma: linha['idioma']! as String,
      notificacoesAtivas: linha['notificacoes_ativas'] == 1,
      lembretesTarefas: linha['lembretes_tarefas'] == 1,
      tarefasAtrasadas: linha['tarefas_atrasadas'] == 1,
      somNotificacoes: linha['som_notificacoes'] == 1,
      formato24Horas: linha['formato_24_horas'] == 1,
      primeiroDiaSemana: linha['primeiro_dia_semana']! as String,
      formatoData: linha['formato_data']! as String,
    );
  }

  Future<void> guardar({
    required String tema,
    required String idioma,
    required bool notificacoesAtivas,
    required bool lembretesTarefas,
    required bool tarefasAtrasadas,
    required bool somNotificacoes,
    required bool formato24Horas,
    required String primeiroDiaSemana,
    required String formatoData,
  }) async {
    final db = await AppDatabase.instancia.database;
    await db.update(
      'preferencias',
      {
        'tema': tema,
        'idioma': idioma,
        'notificacoes_ativas': notificacoesAtivas ? 1 : 0,
        'usar_cloud': 0,
        'lembretes_tarefas': lembretesTarefas ? 1 : 0,
        'tarefas_atrasadas': tarefasAtrasadas ? 1 : 0,
        'som_notificacoes': somNotificacoes ? 1 : 0,
        'formato_24_horas': formato24Horas ? 1 : 0,
        'primeiro_dia_semana': primeiroDiaSemana,
        'formato_data': formatoData,
      },
      where: 'utilizador_id = ?',
      whereArgs: [AppDatabase.utilizadorLocalId],
    );
  }
}
