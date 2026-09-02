import '../models/transaction.dart';
import 'transaction_database.dart';
import 'sample_transactions.dart';

//connects to Transaction_database (SQL)
class TransactionRepository {
  final TransactionDatabase _transactionDatabase = TransactionDatabase.instance;

  Future<List<Transaction>> getAll() async {
    final db = await _transactionDatabase.database;
    final maps = await db.query('transactions'); //get all rows from the transactions table
    return maps.map((map) => Transaction.fromMap(map)).toList(); //convert each row (map) into a Transaction object
  }

  Future<Transaction> insert(Transaction transaction) async {
    final db = await _transactionDatabase.database;
    final id = await db.insert('transactions', transaction.toMap());
    return transaction.copyWith(id: id); //return a the new Transaction object with the id assigned by the database.
  }

  Future<void> update(Transaction transaction) async {
    assert(transaction.id != null,
        'Cannot update a transaction that has not been inserted yet (id is null)');
    final db = await _transactionDatabase.database;
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _transactionDatabase.database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  
  //seed sample data if table is empty. 
  // Known limitation: if a user later deletes every real transaction,
  // the table becomes empty again and this will re-seed the sample data
  // on the next launch.
  Future<void> seedIfEmpty() async {
    final db = await _transactionDatabase.database;
    final existing = await db.query('transactions', limit: 1);
    if (existing.isNotEmpty) return;

    for (final transaction in sampleTransactions()) {
      await insert(transaction);
    }
  }
}