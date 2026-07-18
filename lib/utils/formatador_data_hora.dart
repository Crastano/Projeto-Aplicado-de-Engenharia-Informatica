import 'package:pei/controller/configuracoes_controlador.dart';

class FormatadorDataHora {
  const FormatadorDataHora._();

  static ConfiguracoesControlador get _configuracoes =>
      ConfiguracoesControlador.instancia;

  static String data(DateTime valor) {
    final dia = valor.day.toString().padLeft(2, '0');
    final mes = valor.month.toString().padLeft(2, '0');
    final ano = valor.year.toString();

    return switch (_configuracoes.formatoData) {
      'dd-MM-yyyy' => '$dia-$mes-$ano',
      'yyyy-MM-dd' => '$ano-$mes-$dia',
      'MM/dd/yyyy' => '$mes/$dia/$ano',
      _ => '$dia/$mes/$ano',
    };
  }

  static String hora(DateTime valor) {
    final minuto = valor.minute.toString().padLeft(2, '0');

    if (_configuracoes.formato24Horas) {
      final hora = valor.hour.toString().padLeft(2, '0');
      return '$hora:$minuto';
    }

    final periodo = valor.hour < 12 ? 'AM' : 'PM';
    final hora12 = valor.hour % 12 == 0 ? 12 : valor.hour % 12;
    return '$hora12:$minuto $periodo';
  }

  static String dataHora(DateTime valor) {
    return '${data(valor)} ${hora(valor)}';
  }
}
