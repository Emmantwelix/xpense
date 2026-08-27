// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xpense/app.dart';

void main() {
  testWidgets('app renders the transaction list screen', (tester) async {
    await tester.pumpWidget(const XpenseApp());

    expect(find.text('Xpense'), findsOneWidget);
    expect(find.text('No transactions yet'), findsOneWidget);
  });
}