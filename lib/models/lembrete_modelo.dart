// Enums
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/unidade_lembrete.dart';

class LembreteModelo {
  const LembreteModelo({
    required this.id,
    required this.tarefaId,
    required this.tipo,
    this.unidade,
    this.quantidade,
  });

  final int id;
  final String tarefaId;
  final Lembrete tipo;
  final UnidadeLembrete? unidade;
  final int? quantidade;
}
