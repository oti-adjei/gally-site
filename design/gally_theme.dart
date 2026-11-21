import 'package:flutter/material.dart';

// OPTIONAL Material interoperability adapter, not the Gally component system.
// The cross-platform design is custom. Prefer gally_components.dart for shared widgets.
// Verify SDK role support in your app's pinned Flutter version.
const gallyLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF184D3D),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDFF3E9),
  onPrimaryContainer: Color(0xFF143C30),
  secondary: Color(0xFFD9ED92),
  onSecondary: Color(0xFF243219),
  secondaryContainer: Color(0xFFEEF5D9),
  onSecondaryContainer: Color(0xFF34451D),
  tertiary: Color(0xFF526D79),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE4EFF3),
  onTertiaryContainer: Color(0xFF243E49),
  error: Color(0xFFAE343A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFBE9E9),
  onErrorContainer: Color(0xFF842329),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF182E27),
  onSurfaceVariant: Color(0xFF5E6E66),
  outline: Color(0xFF718078),
  outlineVariant: Color(0xFFDDE5DF),
  inverseSurface: Color(0xFF182E27),
  onInverseSurface: Color(0xFFF1F5F2),
  scrim: Color(0xFF0A1B14),
  surfaceContainer: Color(0xFFF1F5F2),
);

const gallyDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFACD5BD),
  onPrimary: Color(0xFF10382B),
  primaryContainer: Color(0xFF244F3D),
  onPrimaryContainer: Color(0xFFDFF3E9),
  secondary: Color(0xFFD9ED92),
  onSecondary: Color(0xFF243219),
  secondaryContainer: Color(0xFF34451D),
  onSecondaryContainer: Color(0xFFEEF5D9),
  tertiary: Color(0xFFB1CEDA),
  onTertiary: Color(0xFF19343F),
  tertiaryContainer: Color(0xFF324F5B),
  onTertiaryContainer: Color(0xFFE4EFF3),
  error: Color(0xFFFFB3B6),
  onError: Color(0xFF620E18),
  errorContainer: Color(0xFF4D252A),
  onErrorContainer: Color(0xFFFFDADB),
  surface: Color(0xFF14221C),
  onSurface: Color(0xFFEBF1EC),
  onSurfaceVariant: Color(0xFFB8C6BC),
  outline: Color(0xFF8F9F94),
  outlineVariant: Color(0xFF3C4C41),
  inverseSurface: Color(0xFFEBF1EC),
  onInverseSurface: Color(0xFF14221C),
  scrim: Color(0xFF06100B),
  surfaceContainer: Color(0xFF20332A),
);

ThemeData gallyTheme(Brightness brightness) => ThemeData(
  useMaterial3: true,
  colorScheme: brightness == Brightness.dark ? gallyDark : gallyLight,
  fontFamily: 'Fusion Neue',
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  textTheme: const TextTheme(
    displaySmall: TextStyle(fontFamily: 'Noi Grotesk', fontSize: 36, height: 1.1, letterSpacing: -1.4, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontFamily: 'Noi Grotesk', fontSize: 28, height: 1.15, letterSpacing: -1.1, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontFamily: 'Noi Grotesk', fontSize: 22, height: 1.15, letterSpacing: -0.8),
    bodyLarge: TextStyle(fontSize: 16, height: 1.55),
    labelLarge: TextStyle(fontSize: 14, height: 1.4, fontWeight: FontWeight.w600),
  ),
);
// Load licensed font files in pubspec.yaml. Use a tabular numeric face or
// FontFeature.tabularFigures() from dart:ui for amounts. Do not ship unlicensed faces.
