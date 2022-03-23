import 'package:fab_nhl/app/resources/colors.dart' as colors;
import 'package:flutter/material.dart';

// configure application theme
ThemeData get light => ThemeData(
      appBarTheme: const AppBarTheme(
        color: colors.primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: colors.primaryColor,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: colors.primaryColor,
    );

ThemeData get dark => ThemeData(
      appBarTheme: const AppBarTheme(
        color: colors.primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: colors.primaryColor,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: colors.primaryColor,
    );
