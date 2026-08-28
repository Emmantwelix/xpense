import '../models/transaction.dart';

//stand in for real data
List<Transaction> sampleTransactions() {
  return [
    Transaction(id: 't1', description: 'Paycheque', category: 'Salary', date: DateTime(2026, 8, 1), amount: 2100.00, type: TransactionType.income),
    Transaction(id: 't2', description: 'Rent', category: 'Housing', date: DateTime(2026, 8, 1), amount: 950.00, type: TransactionType.expense),
    Transaction(id: 't3', description: 'Groceries - Superstore', category: 'Food', date: DateTime(2026, 8, 3), amount: 87.32, type: TransactionType.expense),
    Transaction(id: 't4', description: 'Bus pass', category: 'Transport', date: DateTime(2026, 8, 4), amount: 102.30, type: TransactionType.expense),
    Transaction(id: 't5', description: 'Freelance web work', category: 'Side income', date: DateTime(2026, 8, 6), amount: 300.00, type: TransactionType.income),
    Transaction(id: 't6', description: 'Netflix', category: 'Entertainment', date: DateTime(2026, 8, 7), amount: 16.99, type: TransactionType.expense),
    Transaction(id: 't7', description: 'Electricity bill', category: 'Utilities', date: DateTime(2026, 8, 10), amount: 64.18, type: TransactionType.expense),
    Transaction(id: 't8', description: 'Dinner with friends', category: 'Food', date: DateTime(2026, 8, 12), amount: 42.50, type: TransactionType.expense),
    Transaction(id: 't9', description: 'Refund - returned item', category: 'Other', date: DateTime(2026, 8, 14), amount: 25.00, type: TransactionType.income),
    Transaction(id: 't10', description: 'Gas', category: 'Transport', date: DateTime(2026, 8, 15), amount: 55.40, type: TransactionType.expense),
  ];
}