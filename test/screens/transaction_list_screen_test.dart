import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xpense/screens/transaction_list_screen.dart';

void main() {
  testWidgets('TransactionListScreen shows transactions and correct totals',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionListScreen()));

    // The first transaction is visible without scrolling.
    expect(find.text('Paycheque'), findsOneWidget);

    //scroll to the bottom because ListView.builder only builds what's near the
    // viewport, so the last item doesn't exist in the tree until we
    // scroll far enough to bring it in.
    await tester.drag(find.byType(ListView), const Offset(0, -2000)); //simulate swipe
    await tester.pumpAndSettle();

    expect(find.text('Gas'), findsOneWidget);

    // The balance header's totals are correct, not just present.
    expect(find.text('\$2425.00'), findsOneWidget);
    expect(find.text('\$1318.69'), findsOneWidget);
    expect(find.text('\$1106.31'), findsOneWidget);
  });
}