import 'package:flutter/material.dart';

class ConfiguracoesControlador extends ChangeNotifier {
  ConfiguracoesControlador._();

  static final ConfiguracoesControlador instancia =
      ConfiguracoesControlador._();

  ThemeMode tema = ThemeMode.light;

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
      'Español' => '🇪🇸',
      'Français' => '🇫🇷',
      'Deutsch' => '🇩🇪',
      _ => '🌐',
    };
  }

  void alterarTema(ThemeMode valor) {
    tema = valor;
    notifyListeners();
  }

  void alterarNotificacoesAtivas(bool valor) {
    notificacoesAtivas = valor;
    notifyListeners();
  }

  void alterarLembretesTarefas(bool valor) {
    lembretesTarefas = valor;
    notifyListeners();
  }

  void alterarTarefasAtrasadas(bool valor) {
    tarefasAtrasadas = valor;
    notifyListeners();
  }

  void alterarSomNotificacoes(bool valor) {
    somNotificacoes = valor;
    notifyListeners();
  }

  void alterarFormato24Horas(bool valor) {
    formato24Horas = valor;
    notifyListeners();
  }

  void alterarPrimeiroDiaSemana(String valor) {
    primeiroDiaSemana = valor;
    notifyListeners();
  }

  void alterarFormatoData(String valor) {
    formatoData = valor;
    notifyListeners();
  }

  void alterarIdioma(String valor) {
    idioma = valor;
    notifyListeners();
  }
}
