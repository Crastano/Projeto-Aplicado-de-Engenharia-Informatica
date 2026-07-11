import 'package:flutter/material.dart';

import 'app_cores.dart';

ThemeData temaClaro() => ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppCores.backgroundClaro,

  fontFamily: 'Inter',

  colorScheme: const .light(
    primary: AppCores.primary,
    onPrimary: Colors.white,
    secondary: AppCores.primary,
    onSecondary: Colors.white,
    error: AppCores.atrasadoBackgroundClaro,
    onError: AppCores.atrasadoTextClaro,
    surface: AppCores.surfaceClaro,
    onSurface: AppCores.textoPrincipalClaro,
    outline: AppCores.borderClaro,
    shadow: AppCores.cardShadowClaro,
  ),

  appBarTheme: AppBarThemeData(
    backgroundColor: AppCores.backgroundClaro,
    foregroundColor: AppCores.textoPrincipalClaro,
    actionsIconTheme: IconThemeData(color: AppCores.textoPrincipalClaro),
    shadowColor: AppCores.cardShadowClaro,
    elevation: 2,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: AppCores.primary),
    unselectedIconTheme: IconThemeData(color: AppCores.iconClaro),
    selectedLabelStyle: TextStyle(color: AppCores.primary),
    unselectedLabelStyle: TextStyle(color: AppCores.iconClaro),
    elevation: 0,
  ),

  dividerTheme: DividerThemeData(color: AppCores.borderClaro, thickness: 2),

  iconTheme: IconThemeData(color: AppCores.iconClaro),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppCores.primary,
      foregroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.white, fontWeight: .w500),
    ),
  ),

  cardTheme: CardThemeData(
    color: AppCores.surfaceClaro,
    shadowColor: AppCores.cardShadowClaro,
    elevation: 2,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 0,
    shape: CircleBorder(),
  ),

  popupMenuTheme: PopupMenuThemeData(
    position: PopupMenuPosition.under,
    shadowColor: AppCores.cardShadowClaro,
    elevation: 2,
  ),

  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      visualDensity: VisualDensity.comfortable,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: AppCores.surfaceClaro,
      selectedBackgroundColor: AppCores.primary,
    ),
  ),
);