import 'package:flutter/material.dart';

import 'app_cores.dart';

ThemeData temaEscuro() => ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: AppCores.backgroundEscuro,

  fontFamily: 'Inter',

  colorScheme: const ColorScheme.dark(
    primary: AppCores.primary,
    onPrimary: Colors.white,
    secondary: AppCores.primary,
    onSecondary: Colors.white,
    error: AppCores.atrasadoBackgroundEscuro,
    onError: AppCores.atrasadoTextEscuro,
    surface: AppCores.surfaceEscuro,
    onSurface: AppCores.textoPrincipalEscuro,
    outline: AppCores.borderEscuro,
    shadow: AppCores.cardShadowEscuro,
  ),

  appBarTheme: AppBarThemeData(
    backgroundColor: AppCores.backgroundEscuro,
    foregroundColor: AppCores.textoPrincipalEscuro,
    actionsIconTheme: IconThemeData(color: AppCores.textoPrincipalEscuro),
    shadowColor: AppCores.cardShadowEscuro,
    elevation: 0,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppCores.backgroundEscuro,
    selectedIconTheme: IconThemeData(color: AppCores.primary),
    unselectedIconTheme: IconThemeData(color: AppCores.iconEscuro),
    selectedLabelStyle: TextStyle(color: AppCores.primary),
    unselectedLabelStyle: TextStyle(color: AppCores.iconEscuro),
    elevation: 0,
  ),

  dividerTheme: DividerThemeData(color: AppCores.borderEscuro, thickness: 2),

  iconTheme: IconThemeData(color: AppCores.iconEscuro),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppCores.primary,
      foregroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
  ),

  cardTheme: CardThemeData(
    color: AppCores.surfaceEscuro,
    shadowColor: AppCores.cardShadowEscuro,
    elevation: 0,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 0,
  )
);
