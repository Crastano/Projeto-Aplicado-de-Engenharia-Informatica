import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

// Enums
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_periodicidade.dart';
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/unidade_lembrete.dart';

class ConfiguracaoPeriodicidade {
  const ConfiguracaoPeriodicidade({
    required this.intervalo,
    required this.unidade,
  });

  final int intervalo;
  final UnidadePeriodicidade unidade;
}

class ConfiguracaoLembrete {
  const ConfiguracaoLembrete({required this.quantidade, required this.unidade});

  final int quantidade;
  final UnidadeLembrete unidade;

  Duration get duracao {
    return switch(unidade) {
      .minutos => Duration(minutes: quantidade),
      .horas => Duration(hours: quantidade),
      .dias => Duration(days: quantidade)
    };
  }
}

class TarefasControlador extends ChangeNotifier {
  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');

    return '$dia-$mes-${data.year}';
  }

  int converterParaMinutos(TimeOfDay hora) {
    return hora.hour * 60 + hora.minute;
  }

  // Validação

  bool validarHoras(TimeOfDay inicio, TimeOfDay fim) {
    final minutosHoraInicial = converterParaMinutos(inicio);

    final minutosHoraFinal = converterParaMinutos(fim);

    return minutosHoraFinal <= minutosHoraInicial;
  }

  // Titulo
  final TextEditingController tituloController = TextEditingController();

  String get titulo => tituloController.text.trim();

  bool get tituloValido => titulo.isNotEmpty;

  // Categorias

  final List<String> categorias = [
    'Tarefa',
    'Aniversário',
    'Trabalho',
    'Evento',
    'Pagar',
  ];

  String categoriaSelecionada = 'Tarefa';

  void selecionarCategoria(String categoria) {
    if (categoriaSelecionada == categoria) return;

    categoriaSelecionada = categoria;
    notifyListeners();
  }

  void adicionarCategoria(String categoria) {
    final String novaCategoria = categoria.trim();

    if (novaCategoria.isEmpty) return;

    final bool categoriaJaExiste = categorias.any(
      (categoriaExistente) =>
          categoriaExistente.toLowerCase() == novaCategoria.toLowerCase(),
    );

    if (categoriaJaExiste) return;

    categorias.add(novaCategoria);
    categoriaSelecionada = novaCategoria;

    notifyListeners();
  }

  // Periodicidade

  ConfiguracaoPeriodicidade configuracaoPeriodicidadePersonalizada =
      ConfiguracaoPeriodicidade(
        intervalo: 1,
        unidade: UnidadePeriodicidade.dias,
      );

  String formatarPeriodicidade(Periodicidade periodicidade) {
    return switch(periodicidade) {
      .nenhuma => 'Não repetir',
      .diaria => 'Diaramente',
      .semanal => 'Semanalmente',
      .mensal => 'Mensalmente',
      .anual => 'Anualmente',
      .personalizada => formatarPersonalizada(configuracaoPeriodicidadePersonalizada)
    };
  }


  String formatarUnidadePeriodicidade(UnidadePeriodicidade unidade, int intervalo) {
    return switch(unidade) {
      .dias => intervalo == 1 ? 'dia' : 'dias',
      .semanas => intervalo == 1 ? 'semana' : 'semanas',
      .meses => intervalo == 1 ? 'mês' : 'meses',
      .anos => intervalo == 1 ? 'ano' : 'anos',
    };
  }

  String formatarPersonalizada(ConfiguracaoPeriodicidade configuracao) {
    final intervalo = configuracao.intervalo;

    return switch(configuracao.unidade) {
      .dias => intervalo == 1 ? 'Todos os dias' : 'A cada $intervalo dias',
      .semanas => intervalo == 1
            ? 'Todas as semanas'
            : 'A cada $intervalo semanas',
      .meses => intervalo == 1 ? 'Todos os meses' : 'A cada $intervalo meses',
      .anos => intervalo == 1 ? 'Todos os anos' : 'A cada $intervalo anos',
    };
  }

  IconData obterIconePeriodicidade(Periodicidade periodicidade) {
    return switch(periodicidade) {
      .nenhuma => Icons.block_outlined,
      .diaria => Icons.today_outlined,
      .semanal => Icons.date_range_outlined,
      .mensal => Icons.calendar_month_outlined,
      .anual => Icons.event_repeat_outlined,
      .personalizada => Icons.tune_outlined,
    };
  }

  // Lembrete

  ConfiguracaoLembrete configuracaoLembretePersonalizada =
      const ConfiguracaoLembrete(quantidade: 1, unidade: UnidadeLembrete.horas);

  String formatarLembrete(Lembrete lembrete) {
    return switch(lembrete) {
      .nenhum => 'Sem lembrete',
      .noMomento => 'Na hora da tarefa',
      .cincoMinutos => '5 minutos antes',
      .dezMinutos => '10 minutos antes',
      .quinzeMinutos => '15 minutos antes',
      .trintaMinutos => '30 minutos antes',
      .umaHora => '1 hora antes',
      .umDia => '1 dia antes',
      .personalizada => formatarLembretePersonalizado(configuracaoLembretePersonalizada),
    };
  }  


  String formatarLembretePersonalizado(ConfiguracaoLembrete configuracao) {
    final quantidade = configuracao.quantidade;

    return switch(configuracao.unidade) {
      .minutos => quantidade == 1 ? '1 minuto antes' : '$quantidade minutos antes',
      .horas => quantidade == 1 ? '1 hora antes' : '$quantidade horas antes',
      .dias => quantidade == 1 ? '1 dia antes' : '$quantidade dias antes',
    };
  }

  IconData obterIconeLembrete(Lembrete lembrete) {
    return switch(lembrete) {
      .nenhum => Icons.notifications_off_outlined,
      .noMomento => Icons.notifications_active_outlined,
      .cincoMinutos => Icons.timer_outlined,
      .dezMinutos => Icons.timer_outlined,
      .quinzeMinutos => Icons.timer_outlined,
      .trintaMinutos => Icons.timer_outlined,
      .umaHora => Icons.schedule_outlined,
      .umDia => Icons.calendar_today_outlined,
      .personalizada => Icons.tune_outlined,
    };
  }

  String formatarUnidadeLembrete(UnidadeLembrete unidade, int quantidade) {
    return switch(unidade) {
      .minutos => quantidade == 1 ? 'minuto' : 'minutos',
      .horas => quantidade == 1 ? 'hora' : 'horas',
      .dias => quantidade == 1 ? 'dia' : 'dias',
    };
  }

  // Anexos

  List<PlatformFile> anexos = [];

  IconData obterIconeAnexos(String? extensao) {
    return switch(extensao?.toLowerCase()) {
      'jpg' => Icons.image_outlined,
      'jpeg' => Icons.image_outlined,
      'png' => Icons.image_outlined,
      'webp' => Icons.image_outlined,
      'pdf' => Icons.picture_as_pdf_outlined,
      'doc' => Icons.description_outlined,
      'docx' => Icons.description_outlined,
      'xls' => Icons.table_chart_outlined,
      'xlsx' => Icons.table_chart_outlined,
      'mp3' => Icons.audio_file_outlined,
      'wav' => Icons.audio_file_outlined,
      'mp4' => Icons.video_file_outlined,
      'mov' => Icons.video_file_outlined,
      String() => Icons.insert_drive_file_outlined,
      null => Icons.insert_drive_file_outlined,
    };
  }

  String obterNomeSemExtensao(PlatformFile anexo) {
    final extensao = anexo.extension;

    if (extensao == null || extensao.isEmpty) {
      return anexo.name;
    }

    final sufixo = '.$extensao';

    if (anexo.name.toLowerCase().endsWith(sufixo.toLowerCase())) {
      return anexo.name.substring(0, anexo.name.length - sufixo.length);
    }

    return anexo.name;
  }

  String mensagemAnexo(OpenResult resultado) {
    return switch(resultado.type) {
      .fileNotFound => 'O ficheiro já não existe.',
      .noAppToOpen => 'Não existe nenhuma aplicação capaz de abrir este ficheiro.',
      .permissionDenied => 'Não existe permissão para abrir este ficheiro.',
      .error => 'Não foi possível abrir o ficheiro.',
      .done => '',
    };
  }
}
