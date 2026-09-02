import 'package:flutter_test/flutter_test.dart';
import 'package:xpense/models/transaction.dart';

void main() {
  group('Transaction', () {
    test('signedAmount is positive for income', () {
      final t = Transaction(
        id: 1,
        description: 'Paycheque',
        category: 'Salary',
        date: DateTime(2026, 8, 15),
        amount: 1200.0,
        type: TransactionType.income,
      );
      expect(t.signedAmount, 1200.0);
    });

    test('signedAmount is negative for expense', () {
      final t = Transaction(
        id: 2,
        description: 'Groceries',
        category: 'Food',
        date: DateTime(2026, 8, 16),
        amount: 85.50,
        type: TransactionType.expense,
      );
      expect(t.signedAmount, -85.50);
    });

    test('rejects a negative amount', () {
      expect(
        () => Transaction(
          id: 3,
          description: 'Bad data',
          category: 'Test',
          date: DateTime(2026, 8, 16),
          amount: -10,
          type: TransactionType.expense,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('id is nullable, for a transaction not yet saved', () {
      final t = Transaction(
        description: 'Cash tip',
        category: 'Side income',
        date: DateTime(2026, 8, 17),
        amount: 20.0,
        type: TransactionType.income,
      );
      expect(t.id, isNull);
    });

    test('toMap then fromMap reproduces an equivalent Transaction', () {
      final original = Transaction(
        id: 7,
        description: 'Bus pass',
        category: 'Transport',
        date: DateTime(2026, 8, 4),
        amount: 102.30,
        type: TransactionType.expense,
      );

      final roundTripped = Transaction.fromMap(original.toMap());

      expect(roundTripped, original);
    });

    test('toMap stores type as its name string, not its numeric index', () {
      final t = Transaction(
        id: 1,
        description: 'Test',
        category: 'Test',
        date: DateTime(2026, 8, 1),
        amount: 10.0,
        type: TransactionType.expense,
      );
      expect(t.toMap()['type'], 'expense');
    });
  });
}