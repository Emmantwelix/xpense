import 'package:flutter_test/flutter_test.dart';
import 'package:xpense/data/transaction_database.dart';
import 'package:xpense/data/transaction_repository.dart';
import 'package:xpense/models/transaction.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction; //sqflite_ffi has a Transaction class that conflicts with our model, so hide it

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiNoIsolate;
    TransactionDatabase.overridePath = inMemoryDatabasePath;
  });

  tearDown(() async {
    await TransactionDatabase.instance.close();
  });

  Transaction sample({String description = 'Groceries'}) => Transaction(
        description: description,
        category: 'Food',
        date: DateTime(2026, 8, 3),
        amount: 42.50,
        type: TransactionType.expense,
      );

  group('TransactionRepository', () {
    test('insert assigns an id and getAll returns the row', () async {
      final repo = TransactionRepository();

      final inserted = await repo.insert(sample());

      expect(inserted.id, isNotNull);
      expect(await repo.getAll(), [inserted]);
    });

    test('update changes the stored row in place', () async {
      final repo = TransactionRepository();
      final inserted = await repo.insert(sample());

      await repo.update(inserted.copyWith(amount: 99.99));

      final all = await repo.getAll();
      expect(all.length, 1);
      expect(all.first.id, inserted.id);
      expect(all.first.amount, 99.99);
    });

    test('delete removes the row', () async {
      final repo = TransactionRepository();
      final inserted = await repo.insert(sample());

      await repo.delete(inserted.id!);

      expect(await repo.getAll(), isEmpty);
    });

    test('getAll returns newest first', () async {
      final repo = TransactionRepository();
      await repo.insert(sample(description: 'Older').copyWith(date: DateTime(2026, 8, 1)));
      await repo.insert(sample(description: 'Newer').copyWith(date: DateTime(2026, 8, 20)));

      final all = await repo.getAll();

      expect(all.map((t) => t.description), ['Newer', 'Older']);
    });

    test('seedIfEmpty seeds once and never twice', () async {
      final repo = TransactionRepository();

      await repo.seedIfEmpty();
      await repo.seedIfEmpty();

      expect((await repo.getAll()).length, 10);
    });
  });
}