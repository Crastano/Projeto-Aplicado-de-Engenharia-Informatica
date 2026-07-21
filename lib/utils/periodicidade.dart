// Enums
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_periodicidade.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

class PeriodicidadeUtils {
  const PeriodicidadeUtils._();

  static TarefaModelo? criarProximaOcorrencia(TarefaModelo tarefa) {
    if (!tarefa.estaRepetindo) return null;

    final proximaData = calcularProximaData(tarefa);
    final proximaDataLimite = calcularProximaDataLimite(
      tarefa: tarefa,
      proximaData: proximaData,
    );

    return TarefaModelo(
      id: criarIdOcorrencia(tarefa.id, proximaData),
      titulo: tarefa.titulo,
      data: proximaData,
      hora: tarefa.hora,
      dataLimite: proximaDataLimite,
      categoryId: tarefa.categoryId,
      category: tarefa.category,
      lembrete: tarefa.lembrete,
      lembreteQuantidade: tarefa.lembreteQuantidade,
      lembreteUnidade: tarefa.lembreteUnidade,
      periodicidade: tarefa.periodicidade,
      periodicidadeIntervalo: tarefa.periodicidadeIntervalo,
      periodicidadeUnidade: tarefa.periodicidadeUnidade,
      notas: tarefa.notas,
      anexos: const [],
      estaCompletado: false,
      estaCancelada: false,
      criadoEm: DateTime.now(),
    );
  }

  static DateTime calcularProximaData(TarefaModelo tarefa) {
    final data = apenasData(tarefa.data);

    return switch (tarefa.periodicidade) {
      Periodicidade.nenhuma => data,
      Periodicidade.diaria => adicionarDias(data, 1),
      Periodicidade.semanal => adicionarDias(data, 7),
      Periodicidade.mensal => adicionarMeses(data, 1),
      Periodicidade.anual => adicionarMeses(data, 12),
      Periodicidade.personalizada => adicionarPersonalizada(tarefa, data),
    };
  }

  static DateTime adicionarPersonalizada(
    TarefaModelo tarefa,
    DateTime data,
  ) {
    final intervalo = intervaloValido(tarefa.periodicidadeIntervalo);
    final unidade = tarefa.periodicidadeUnidade ?? UnidadePeriodicidade.dias;

    return switch (unidade) {
      UnidadePeriodicidade.dias => adicionarDias(data, intervalo),
      UnidadePeriodicidade.semanas => adicionarDias(data, intervalo * 7),
      UnidadePeriodicidade.meses => adicionarMeses(data, intervalo),
      UnidadePeriodicidade.anos => adicionarMeses(data, intervalo * 12),
    };
  }

  static DateTime? calcularProximaDataLimite({
    required TarefaModelo tarefa,
    required DateTime proximaData,
  }) {
    final dataLimite = tarefa.dataLimite;
    if (dataLimite == null) return null;

    final diferencaEmDias = apenasData(dataLimite)
        .difference(apenasData(tarefa.data))
        .inDays;

    return adicionarDias(proximaData, diferencaEmDias);
  }

  static DateTime adicionarDias(DateTime data, int dias) {
    return DateTime(data.year, data.month, data.day + dias);
  }

  static DateTime adicionarMeses(DateTime data, int meses) {
    final totalMeses = data.year * 12 + (data.month - 1) + meses;
    final ano = totalMeses ~/ 12;
    final mes = totalMeses % 12 + 1;
    final ultimoDiaDoMes = DateTime(ano, mes + 1, 0).day;
    final dia = data.day > ultimoDiaDoMes ? ultimoDiaDoMes : data.day;

    return DateTime(ano, mes, dia);
  }

  static DateTime apenasData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  static int intervaloValido(int? intervalo) {
    if (intervalo == null || intervalo < 1) return 1;
    return intervalo;
  }

  static String criarIdOcorrencia(String tarefaId, DateTime proximaData) {
    final instante = DateTime.now().microsecondsSinceEpoch;
    return instante.toString();
  }
}
