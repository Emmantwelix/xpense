import 'package:flutter_test/flutter_test.dart';
import 'package:xpense/models/transaction.dart';

void main() {
  group('Transaction', () {
    //income test
    test('signedAmount is positive for income', () {
      final t = Transaction(
        id: 't1',
        description: 'Paycheque',
        category: 'Salary',
        date: DateTime(2026, 8, 15),
        amount: 1200.0,
        type: TransactionType.income,
      );

      expect(t.signedAmount, 1200.0);
    });

    test('signedAmount is negative for expense', () {
      //expense test
      final t = Transaction(
        id: 't2',
        description: 'Groceries',
        category: 'Food',
        date: DateTime(2026, 8, 16),
        amount: 85.50,
        type: TransactionType.expense,
      );

      expect(t.signedAmount, -85.50);
    });

    test('rejects a negative amount', () {
      //negative value test
      expect(
        () => Transaction(
          id: 't3',
          description: 'Bad data',
          category: 'Test',
          date: DateTime(2026, 8, 16),
          amount: -10,
          type: TransactionType.expense,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}