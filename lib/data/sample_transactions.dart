import '../models/transaction.dart';

//stand in for real data
List<Transaction> sampleTransactions() {
  return [
    Transaction(description: 'Paycheque', category: 'Salary', date: DateTime(2026, 8, 1), amount: 2100.00, type: TransactionType.income),
    Transaction(description: 'Rent', category: 'Housing', date: DateTime(2026, 8, 1), amount: 950.00, type: TransactionType.expense),
    Transaction(description: 'Groceries - Superstore', category: 'Food', date: DateTime(2026, 8, 3), amount: 87.32, type: TransactionType.expense),
    Transaction(description: 'Bus pass', category: 'Transport', date: DateTime(2026, 8, 4), amount: 102.30, type: TransactionType.expense),
    Transaction(description: 'Freelance web work', category: 'Side income', date: DateTime(2026, 8, 6), amount: 300.00, type: TransactionType.income),
    Transaction(description: 'Netflix', category: 'Entertainment', date: DateTime(2026, 8, 7), amount: 16.99, type: TransactionType.expense),
    Transaction(description: 'Electricity bill', category: 'Utilities', date: DateTime(2026, 8, 10), amount: 64.18, type: TransactionType.expense),
    Transaction(description: 'Dinner with friends', category: 'Food', date: DateTime(2026, 8, 12), amount: 42.50, type: TransactionType.expense),
    Transaction(description: 'Refund - returned item', category: 'Other', date: DateTime(2026, 8, 14), amount: 25.00, type: TransactionType.income),
    Transaction(description: 'Gas', category: 'Transport', date: DateTime(2026, 8, 15), amount: 55.40, type: TransactionType.expense),
  ];
}