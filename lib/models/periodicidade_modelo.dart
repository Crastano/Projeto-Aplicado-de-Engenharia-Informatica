// Enums
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_periodicidade.dart';

class PeriodicidadeModelo {
  const PeriodicidadeModelo({
    required this.id,
    required this.tarefaId,
    required this.tipo,
    this.unidade,
    this.intervalo,
  });

  final int id;
  final String tarefaId;
  final Periodicidade tipo;
  final UnidadePeriodicidade? unidade;
  final int? intervalo;
}
