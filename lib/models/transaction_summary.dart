// lib/models/transaction_summary.dart

import 'transaction.dart';

//money in, money out, net.
//walk through list and add signed amount
//extension adds a field (ex.totalIncome) to List<Transaction> 
extension TransactionSummary on List<Transaction> {
  double get totalIncome => where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount); //income

  double get totalExpense => where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount); //expense

  double get netBalance => fold(0.0, (sum, t) => sum + t.signedAmount); //net
}