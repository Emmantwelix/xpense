import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:xpense/data/transaction_database.dart';
import 'package:xpense/screens/transaction_list_screen.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit(); // initialize sqflite_ffi for testing
    databaseFactory = databaseFactoryFfiNoIsolate;
    TransactionDatabase.overridePath = inMemoryDatabasePath; //in-memory database is destroyed when it is closed.
  });

  tearDown(() async {
    await TransactionDatabase.instance.close();
  });

  testWidgets('TransactionListScreen shows transactions and correct totals',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionListScreen()));
    await tester.pumpAndSettle(); //wait for screen to finish loading.
  
    // Newest first: Gas (Aug 15) is at the top without scrolling.
    expect(find.text('Gas'), findsOneWidget);

    //scroll to the bottom because ListView.builder only builds what's near the
    // viewport, so the last item doesn't exist in the tree until we
    // scroll far enough to bring it in.
    await tester.drag(find.byType(ListView), const Offset(0, -2000)); //simulate scroll
    await tester.pumpAndSettle();

    // Oldest is now at the bottom.
    expect(find.text('Paycheque'), findsOneWidget);

    expect(find.text('\$2425.00'), findsOneWidget);
    expect(find.text('\$1318.69'), findsOneWidget);
    expect(find.text('\$1106.31'), findsOneWidget);
  });
}