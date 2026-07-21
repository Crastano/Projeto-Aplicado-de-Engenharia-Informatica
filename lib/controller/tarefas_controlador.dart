import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

// Controladores
import 'package:pei/controller/categorias_controlador.dart';

// Enums
import 'package:pei/enums/lembrete.dart';
import 'package:pei/enums/periodicidade.dart';
import 'package:pei/enums/unidade_lembrete.dart';
import 'package:pei/enums/unidade_periodicidade.dart';
import 'package:pei/models/categoria_modelo.dart';

// Modelos
import 'package:pei/models/tarefa_modelo.dart';

// Utils
import 'package:pei/utils/formatador_data_hora.dart';

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
    return switch (unidade) {
      .minutos => Duration(minutes: quantidade),
      .horas => Duration(hours: quantidade),
      .dias => Duration(days: quantidade),
    };
  }
}

class TarefasControlador extends ChangeNotifier {
  TarefasControlador({TarefaModelo? tarefaInicial}) {
    tarefaOriginal = tarefaInicial;

    if (tarefaInicial == null) {
      prepararNovaTarefa();
    } else {
      carregarTarefa(tarefaInicial);
    }

    tituloControlador.addListener(aoAlterarTitulo);
  }

  TarefaModelo? tarefaOriginal;

  final TextEditingController tituloControlador = TextEditingController();

  DateTime dataSelecionada = DateTime.now();
  DateTime? dataLimiteSelecionada;
  TimeOfDay? horaSelecionada;
  String? categoriaIdSelecionada;
  Periodicidade periodicidadeSelecionada = .nenhuma;
  Lembrete lembreteSelecionado = .nenhum;
  String nota = '';
  List<PlatformFile> anexos = [];

  ConfiguracaoPeriodicidade configuracaoPeriodicidadePersonalizada =
      ConfiguracaoPeriodicidade(intervalo: 1, unidade: .dias);

  ConfiguracaoLembrete configuracaoLembretePersonalizada = ConfiguracaoLembrete(
    quantidade: 1,
    unidade: .horas,
  );

  bool get editando => tarefaOriginal != null;
  String get titulo => tituloControlador.text.trim();
  bool get tituloValido => titulo.isNotEmpty;

  DateTime? get dataHora {
    if (horaSelecionada == null) {
      return null;
    }

    return DateTime(
      dataSelecionada.year,
      dataSelecionada.month,
      dataSelecionada.day,
      horaSelecionada!.hour,
      horaSelecionada!.minute,
    );
  }

  DateTime? get dataLimite {
    return apenasDataOuNull(dataLimiteSelecionada);
  }

  void prepararNovaTarefa() {
    final DateTime agora = DateTime.now();

    dataSelecionada = apenasData(agora);

    horaSelecionada = null;

    selecionarCategoriaInicial();
  }

  void carregarTarefa(TarefaModelo tarefa) {
    tituloControlador.text = tarefa.titulo;

    dataSelecionada = apenasData(tarefa.data);
    dataLimiteSelecionada = apenasDataOuNull(tarefa.dataLimite);
    horaSelecionada = tarefa.hora;

    periodicidadeSelecionada = tarefa.periodicidade;
    lembreteSelecionado = tarefa.lembrete;

    nota = tarefa.notas ?? '';

    anexos = tarefa.anexos.map(platformFileAPartirDoCaminho).toList();

    configuracaoPeriodicidadePersonalizada = ConfiguracaoPeriodicidade(
      intervalo: tarefa.periodicidadeIntervalo ?? 1,
      unidade: tarefa.periodicidadeUnidade ?? .dias,
    );

    configuracaoLembretePersonalizada = ConfiguracaoLembrete(
      quantidade: tarefa.lembreteQuantidade ?? 1,
      unidade: tarefa.lembreteUnidade ?? .horas,
    );

    selecionarCategoriaInicial(tarefa);
  }

  void selecionarCategoriaInicial([TarefaModelo? tarefa]) {
    final CategoriasControlador controladorCategorias = CategoriasControlador.instancia;

    if (tarefa == null) {
      categoriaIdSelecionada = null;
      return;
    }

    final CategoriaModelo? categoriaPorId = controladorCategorias.obterPorId(tarefa.categoryId);

    if (categoriaPorId != null) {
      categoriaIdSelecionada = categoriaPorId.id;
      return;
    }

    categoriaIdSelecionada = null;
  }

  String? validar() {
    if (!tituloValido) {
      return 'Escreve um título para a tarefa.';
    }

    final DateTime? limite = dataLimite;

    if (limite != null && limite.isBefore(dataSelecionada)) {
      return 'A data limite não pode ser anterior à data da tarefa.';
    }

    return null;
  }

  TarefaModelo construirTarefa() {
    final categoria = CategoriasControlador.instancia.obterPorId(
      categoriaIdSelecionada,
    );

    final caminhosAnexos = anexos
        .map((anexo) => anexo.path)
        .whereType<String>()
        .where((caminho) => caminho.isNotEmpty)
        .toList(growable: false);

    return TarefaModelo(
      id:
          tarefaOriginal?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      titulo: titulo,
      data: apenasData(dataSelecionada),
      hora: horaSelecionada,
      dataLimite: dataLimite,
      categoryId: categoria?.id,
      category: categoria?.nome,
      lembrete: lembreteSelecionado,
      lembreteQuantidade: lembreteSelecionado == .personalizada
          ? configuracaoLembretePersonalizada.quantidade
          : null,
      lembreteUnidade: lembreteSelecionado == .personalizada
          ? configuracaoLembretePersonalizada.unidade
          : null,
      periodicidade: periodicidadeSelecionada,
      periodicidadeIntervalo: periodicidadeSelecionada == .personalizada
          ? configuracaoPeriodicidadePersonalizada.intervalo
          : null,
      periodicidadeUnidade: periodicidadeSelecionada == .personalizada
          ? configuracaoPeriodicidadePersonalizada.unidade
          : null,
      notas: nota.trim().isEmpty ? null : nota.trim(),
      anexos: caminhosAnexos,
      estaCompletado: tarefaOriginal?.estaCompletado ?? false,
    );
  }

  void selecionarData(DateTime data) {
    dataSelecionada = apenasData(data);

    final limite = dataLimiteSelecionada;
    if (limite != null && apenasData(limite).isBefore(dataSelecionada)) {
      dataLimiteSelecionada = null;
    }

    notifyListeners();
  }

  void selecionarDataLimite(DateTime? data) {
    dataLimiteSelecionada = apenasDataOuNull(data);
    notifyListeners();
  }

  void selecionarHora(TimeOfDay? hora) {
    horaSelecionada = hora;
    notifyListeners();
  }

  void selecionarCategoria(String? categoriaId) {
    if (categoriaIdSelecionada == categoriaId) return;

    categoriaIdSelecionada = categoriaId;
    notifyListeners();
  }

  void selecionarPeriodicidade(
    Periodicidade periodicidade, {
    ConfiguracaoPeriodicidade? configuracao,
  }) {
    periodicidadeSelecionada = periodicidade;

    if (configuracao != null) {
      configuracaoPeriodicidadePersonalizada = configuracao;
    }

    notifyListeners();
  }

  void selecionarLembrete(
    Lembrete lembrete, {
    ConfiguracaoLembrete? configuracao,
  }) {
    lembreteSelecionado = lembrete;

    if (configuracao != null) {
      configuracaoLembretePersonalizada = configuracao;
    }

    notifyListeners();
  }

  void atualizarNota(String valor) {
    nota = valor.trim();
    notifyListeners();
  }

  void atualizarAnexos(List<PlatformFile> novosAnexos) {
    anexos = List<PlatformFile>.from(novosAnexos);
    notifyListeners();
  }

  String formatarData(DateTime data) {
    return FormatadorDataHora.data(data);
  }

  // Periodicidade

  String formatarPeriodicidade(Periodicidade periodicidade) {
    return switch (periodicidade) {
      .nenhuma => 'Não repetir',
      .diaria => 'Diariamente',
      .semanal => 'Semanalmente',
      .mensal => 'Mensalmente',
      .anual => 'Anualmente',
      .personalizada => formatarPersonalizada(
        configuracaoPeriodicidadePersonalizada,
      ),
    };
  }

  String formatarUnidadePeriodicidade(
    UnidadePeriodicidade unidade,
    int intervalo,
  ) {
    return switch (unidade) {
      .dias => intervalo == 1 ? 'dia' : 'dias',
      .semanas => intervalo == 1 ? 'semana' : 'semanas',
      .meses => intervalo == 1 ? 'mês' : 'meses',
      .anos => intervalo == 1 ? 'ano' : 'anos',
    };
  }

  String formatarPersonalizada(ConfiguracaoPeriodicidade configuracao) {
    final intervalo = configuracao.intervalo;

    return switch (configuracao.unidade) {
      .dias => intervalo == 1 ? 'Todos os dias' : 'A cada $intervalo dias',
      .semanas =>
        intervalo == 1 ? 'Todas as semanas' : 'A cada $intervalo semanas',
      .meses => intervalo == 1 ? 'Todos os meses' : 'A cada $intervalo meses',
      .anos => intervalo == 1 ? 'Todos os anos' : 'A cada $intervalo anos',
    };
  }

  IconData obterIconePeriodicidade(Periodicidade periodicidade) {
    return switch (periodicidade) {
      .nenhuma => Icons.block_outlined,
      .diaria => Icons.today_outlined,
      .semanal => Icons.date_range_outlined,
      .mensal => Icons.calendar_month_outlined,
      .anual => Icons.event_repeat_outlined,
      .personalizada => Icons.tune_outlined,
    };
  }

  // Lembretes

  String formatarLembrete(Lembrete lembrete) {
    return switch (lembrete) {
      .nenhum => 'Sem lembrete',
      .noMomento => 'Na hora da tarefa',
      .cincoMinutos => '5 minutos antes',
      .dezMinutos => '10 minutos antes',
      .quinzeMinutos => '15 minutos antes',
      .trintaMinutos => '30 minutos antes',
      .umaHora => '1 hora antes',
      .umDia => '1 dia antes',
      .personalizada => formatarLembretePersonalizado(
        configuracaoLembretePersonalizada,
      ),
    };
  }

  String formatarLembretePersonalizado(ConfiguracaoLembrete configuracao) {
    final quantidade = configuracao.quantidade;

    return switch (configuracao.unidade) {
      .minutos =>
        quantidade == 1 ? '1 minuto antes' : '$quantidade minutos antes',
      .horas => quantidade == 1 ? '1 hora antes' : '$quantidade horas antes',
      .dias => quantidade == 1 ? '1 dia antes' : '$quantidade dias antes',
    };
  }

  IconData obterIconeLembrete(Lembrete lembrete) {
    return switch (lembrete) {
      .nenhum => Icons.notifications_off_outlined,
      .noMomento => Icons.notifications_active_outlined,
      .cincoMinutos ||
      .dezMinutos ||
      .quinzeMinutos ||
      .trintaMinutos => Icons.timer_outlined,
      .umaHora => Icons.schedule_outlined,
      .umDia => Icons.calendar_today_outlined,
      .personalizada => Icons.tune_outlined,
    };
  }

  String formatarUnidadeLembrete(UnidadeLembrete unidade, int quantidade) {
    return switch (unidade) {
      .minutos => quantidade == 1 ? 'minuto' : 'minutos',
      .horas => quantidade == 1 ? 'hora' : 'horas',
      .dias => quantidade == 1 ? 'dia' : 'dias',
    };
  }

  // Anexos

  IconData obterIconeAnexos(String? extensao) {
    return switch (extensao?.toLowerCase()) {
      'jpg' || 'jpeg' || 'png' || 'webp' => Icons.image_outlined,
      'pdf' => Icons.picture_as_pdf_outlined,
      'doc' || 'docx' => Icons.description_outlined,
      'xls' || 'xlsx' => Icons.table_chart_outlined,
      'mp3' || 'wav' => Icons.audio_file_outlined,
      'mp4' || 'mov' => Icons.video_file_outlined,
      _ => Icons.insert_drive_file_outlined,
    };
  }

  String obterNomeSemExtensao(PlatformFile anexo) {
    final extensao = anexo.extension;

    if (extensao == null || extensao.isEmpty) return anexo.name;

    final sufixo = '.$extensao';

    if (anexo.name.toLowerCase().endsWith(sufixo.toLowerCase())) {
      return anexo.name.substring(0, anexo.name.length - sufixo.length);
    }

    return anexo.name;
  }

  String mensagemAnexo(OpenResult resultado) {
    return switch (resultado.type) {
      .fileNotFound => 'O ficheiro não existe.',
      .noAppToOpen =>
        'Não existe nenhuma aplicação capaz de abrir este ficheiro.',
      .permissionDenied => 'Não existe permissão para abrir este ficheiro.',
      .error => 'Não foi possível abrir o ficheiro.',
      .done => '',
    };
  }

  void aoAlterarTitulo() {
    notifyListeners();
  }

  @override
  void dispose() {
    tituloControlador.removeListener(aoAlterarTitulo);
    tituloControlador.dispose();
    super.dispose();
  }

  static DateTime apenasData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  static DateTime? apenasDataOuNull(DateTime? data) {
    if (data == null) return null;

    return apenasData(data);
  }

  static PlatformFile platformFileAPartirDoCaminho(String caminho) {
    final nome = caminho.split(RegExp(r'[/\\]')).last;
    return PlatformFile(name: nome, size: 0, path: caminho);
  }
}
