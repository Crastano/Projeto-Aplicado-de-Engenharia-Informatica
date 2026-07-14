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
    switch (unidade) {
      case UnidadeLembrete.minutos:
        return Duration(minutes: quantidade);

      case UnidadeLembrete.horas:
        return Duration(hours: quantidade);

      case UnidadeLembrete.dias:
        return Duration(days: quantidade);
    }
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
    switch (periodicidade) {
      case Periodicidade.nenhuma:
        return 'Não repetir';

      case Periodicidade.diaria:
        return 'Diariamente';

      case Periodicidade.semanal:
        return 'Semanalmente';

      case Periodicidade.mensal:
        return 'Mensalmente';

      case Periodicidade.anual:
        return 'Anualmente';

      case Periodicidade.personalizada:
        return formatarPersonalizada(configuracaoPeriodicidadePersonalizada);
    }
  }

  String formatarUnidadePeriodicidade(
    UnidadePeriodicidade unidade,
    int intervalo,
  ) {
    switch (unidade) {
      case UnidadePeriodicidade.dias:
        return intervalo == 1 ? 'dia' : 'dias';

      case UnidadePeriodicidade.semanas:
        return intervalo == 1 ? 'semana' : 'semanas';

      case UnidadePeriodicidade.meses:
        return intervalo == 1 ? 'mês' : 'meses';

      case UnidadePeriodicidade.anos:
        return intervalo == 1 ? 'ano' : 'anos';
    }
  }

  String formatarPersonalizada(ConfiguracaoPeriodicidade configuracao) {
    final intervalo = configuracao.intervalo;

    switch (configuracao.unidade) {
      case UnidadePeriodicidade.dias:
        return intervalo == 1 ? 'Todos os dias' : 'A cada $intervalo dias';

      case UnidadePeriodicidade.semanas:
        return intervalo == 1
            ? 'Todas as semanas'
            : 'A cada $intervalo semanas';

      case UnidadePeriodicidade.meses:
        return intervalo == 1 ? 'Todos os meses' : 'A cada $intervalo meses';

      case UnidadePeriodicidade.anos:
        return intervalo == 1 ? 'Todos os anos' : 'A cada $intervalo anos';
    }
  }

  IconData obterIconePeriodicidade(Periodicidade periodicidade) {
    switch (periodicidade) {
      case Periodicidade.nenhuma:
        return Icons.block_outlined;

      case Periodicidade.diaria:
        return Icons.today_outlined;

      case Periodicidade.semanal:
        return Icons.date_range_outlined;

      case Periodicidade.mensal:
        return Icons.calendar_month_outlined;

      case Periodicidade.anual:
        return Icons.event_repeat_outlined;

      case Periodicidade.personalizada:
        return Icons.tune_outlined;
    }
  }

  // Lembrete

  ConfiguracaoLembrete configuracaoLembretePersonalizada =
      const ConfiguracaoLembrete(quantidade: 1, unidade: UnidadeLembrete.horas);

  String formatarLembrete(Lembrete lembrete) {
    switch (lembrete) {
      case Lembrete.nenhum:
        return 'Sem lembrete';

      case Lembrete.noMomento:
        return 'Na hora da tarefa';

      case Lembrete.cincoMinutos:
        return '5 minutos antes';

      case Lembrete.dezMinutos:
        return '10 minutos antes';

      case Lembrete.quinzeMinutos:
        return '15 minutos antes';

      case Lembrete.trintaMinutos:
        return '30 minutos antes';

      case Lembrete.umaHora:
        return '1 hora antes';

      case Lembrete.umDia:
        return '1 dia antes';

      case Lembrete.personalizada:
        return formatarLembretePersonalizado(configuracaoLembretePersonalizada);
    }
  }

  String formatarLembretePersonalizado(ConfiguracaoLembrete configuracao) {
    final quantidade = configuracao.quantidade;

    switch (configuracao.unidade) {
      case UnidadeLembrete.minutos:
        return quantidade == 1 ? '1 minuto antes' : '$quantidade minutos antes';

      case UnidadeLembrete.horas:
        return quantidade == 1 ? '1 hora antes' : '$quantidade horas antes';

      case UnidadeLembrete.dias:
        return quantidade == 1 ? '1 dia antes' : '$quantidade dias antes';
    }
  }

  IconData obterIconeLembrete(Lembrete lembrete) {
    switch (lembrete) {
      case Lembrete.nenhum:
        return Icons.notifications_off_outlined;

      case Lembrete.noMomento:
        return Icons.notifications_active_outlined;

      case Lembrete.cincoMinutos:
      case Lembrete.dezMinutos:
      case Lembrete.quinzeMinutos:
      case Lembrete.trintaMinutos:
        return Icons.timer_outlined;

      case Lembrete.umaHora:
        return Icons.schedule_outlined;

      case Lembrete.umDia:
        return Icons.calendar_today_outlined;

      case Lembrete.personalizada:
        return Icons.tune_outlined;
    }
  }

  String formatarUnidadeLembrete(UnidadeLembrete unidade, int quantidade) {
    switch (unidade) {
      case UnidadeLembrete.minutos:
        return quantidade == 1 ? 'minuto' : 'minutos';

      case UnidadeLembrete.horas:
        return quantidade == 1 ? 'hora' : 'horas';

      case UnidadeLembrete.dias:
        return quantidade == 1 ? 'dia' : 'dias';
    }
  }

  // Anexos

  List<PlatformFile> anexos = [];

  IconData obterIconeAnexos(String? extensao) {
    switch (extensao?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
        return Icons.image_outlined;

      case 'pdf':
        return Icons.picture_as_pdf_outlined;

      case 'doc':
      case 'docx':
        return Icons.description_outlined;

      case 'xls':
      case 'xlsx':
        return Icons.table_chart_outlined;

      case 'mp3':
      case 'wav':
        return Icons.audio_file_outlined;

      case 'mp4':
      case 'mov':
        return Icons.video_file_outlined;

      default:
        return Icons.insert_drive_file_outlined;
    }
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
    switch (resultado.type) {
      case ResultType.fileNotFound:
        return 'O ficheiro já não existe.';

      case ResultType.noAppToOpen:
        return 'Não existe nenhuma aplicação capaz de abrir este ficheiro.';

      case ResultType.permissionDenied:
        return 'Não existe permissão para abrir este ficheiro.';

      case ResultType.error:
        return 'Não foi possível abrir o ficheiro.';

      case ResultType.done:
        return '';
    }
  }
}
