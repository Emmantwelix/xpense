//an enum for simplicity
enum TransactionType { income, expense }



//[amount] is always a non-negative value, [type] carries the
// direction. Use [signedAmount] wherever you need a value that can be
// summed directly (e.g. computing a balance).
class Transaction {
  final String id;
  final String description;
  final String category;
  final DateTime date;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.description,
    required this.category,
    required this.date,
    required this.amount,
    required this.type,
  }) : assert(amount >= 0, 'amount must be non-negative; use type to signal direction');

  //return signed amount
  //positive for income, negative for expense.
  double get signedAmount => type == TransactionType.income ? amount : -amount;
}