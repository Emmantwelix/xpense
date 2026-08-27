// lib/app.dart

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/transactions/screens/transaction_list_screen.dart';

/// The root widget of Xpense.
///
/// Owns app-wide configuration — title, theme, and (later) routing —
/// and nothing else.
class XpenseApp extends StatelessWidget {
  const XpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpense',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const TransactionListScreen(),
    );
  }
}