// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

/// All colour and typography decisions for Xpense live here.
///
/// Widgets should read from `Theme.of(context)` rather than hardcoding
/// colours, so that changing the palette is a one-file edit.
class AppTheme {
  // Private constructor: this class is a namespace for static members,
  // never something you instantiate.
  AppTheme._();

  /// The colour the whole palette is derived from.
  static const Color _seedColor = Color(0xFF00695C);

  /// Money coming in. Not part of ColorScheme, because Material's scheme
  /// has no concept of "income" — this is domain-specific.
  static const Color income = Color(0xFF2E7D32);

  /// Money going out.
  static const Color expense = Color(0xFFC62828);

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 17, 109, 21),
        brightness: Brightness.light,
      ),
    );
  }
}