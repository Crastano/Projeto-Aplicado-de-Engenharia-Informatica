import 'package:flutter/material.dart';

// Repositorio
import 'package:pei/data/repositories/preferencias_repositorio.dart';

class ConfiguracoesControlador extends ChangeNotifier {
  ConfiguracoesControlador._();

  static final ConfiguracoesControlador instancia =
      ConfiguracoesControlador._();

  final PreferenciasRepositorio _repositorio = PreferenciasRepositorio();
  bool _inicializado = false;

  ThemeMode tema = ThemeMode.system;

  bool notificacoesAtivas = true;
  bool lembretesTarefas = true;
  bool tarefasAtrasadas = true;
  bool somNotificacoes = true;

  bool formato24Horas = true;
  String primeiroDiaSemana = 'Segunda-feira';
  String formatoData = 'dd/MM/yyyy';

  String idioma = 'Português';

  String get nomeTema {
    return switch (tema) {
      ThemeMode.light => 'Claro',
      ThemeMode.dark => 'Escuro',
      ThemeMode.system => 'Sistema',
    };
  }

  String get bandeiraIdioma {
    return switch (idioma) {
      'Português' => '🇵🇹',
      'English' => '🇬🇧',
      _ => '🌐',
    };
  }

  Future<void> inicializar() async {
    if (_inicializado) return;

    final preferencias = await _repositorio.obter();
    tema = switch (preferencias.tema) {
      'claro' => ThemeMode.light,
      'escuro' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    idioma = preferencias.idioma == 'en' ? 'English' : 'Português';
    notificacoesAtivas = preferencias.notificacoesAtivas;
    lembretesTarefas = preferencias.lembretesTarefas;
    tarefasAtrasadas = preferencias.tarefasAtrasadas;
    somNotificacoes = preferencias.somNotificacoes;
    formato24Horas = preferencias.formato24Horas;
    primeiroDiaSemana = preferencias.primeiroDiaSemana;
    formatoData = preferencias.formatoData;

    _inicializado = true;
    notifyListeners();
  }

  Future<void> alterarTema(ThemeMode valor) async {
    tema = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarNotificacoesAtivas(bool valor) async {
    notificacoesAtivas = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarLembretesTarefas(bool valor) async {
    lembretesTarefas = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarTarefasAtrasadas(bool valor) async {
    tarefasAtrasadas = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarSomNotificacoes(bool valor) async {
    somNotificacoes = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarFormato24Horas(bool valor) async {
    formato24Horas = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarPrimeiroDiaSemana(String valor) async {
    primeiroDiaSemana = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarFormatoData(String valor) async {
    formatoData = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> alterarIdioma(String valor) async {
    idioma = valor;
    notifyListeners();
    await _guardar();
  }

  Future<void> _guardar() {
    final temaSql = switch (tema) {
      ThemeMode.light => 'claro',
      ThemeMode.dark => 'escuro',
      ThemeMode.system => 'sistema',
    };

    return _repositorio.guardar(
      tema: temaSql,
      idioma: idioma == 'English' ? 'en' : 'pt',
      notificacoesAtivas: notificacoesAtivas,
      lembretesTarefas: lembretesTarefas,
      tarefasAtrasadas: tarefasAtrasadas,
      somNotificacoes: somNotificacoes,
      formato24Horas: formato24Horas,
      primeiroDiaSemana: primeiroDiaSemana,
      formatoData: formatoData,
    );
  }
}
