//an enum for simplicity
enum TransactionType { income, expense }



//[amount] is always a non-negative value, [type] carries the
// direction. Use [signedAmount] wherever you need a value that can be
// summed directly (e.g. computing a balance).
class Transaction {
  final int? id; //id is given by the database, null when the data is not yet stored.
  final String description;
  final String category;
  final DateTime date;
  final double amount;
  final TransactionType type;

  Transaction({
    this.id,
    required this.description,
    required this.category,
    required this.date,
    required this.amount,
    required this.type,
  }) : assert(amount >= 0, 'amount must be non-negative; use type to signal direction');

  //return signed amount
  //positive for income, negative for expense.
  double get signedAmount => type == TransactionType.income ? amount : -amount;


  //sql: transforms Transaction object into row shape sqflite expects
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'amount': amount,
      'type': type.name, //return enum as a string, not index.
    };
  }

  //sql: transforms row shape sqflite returns into Transaction object
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int?,
      description: map['description'] as String,
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
      amount: map['amount'] as double,
      type: TransactionType.values.byName(map['type'] as String),
    );
  }

  //comparison of two transaction objects.
  @override
  bool operator ==(Object other) {
    return other is Transaction &&
        id == other.id &&
        description == other.description &&
        category == other.category &&
        date == other.date &&
        amount == other.amount &&
        type == other.type;
  }

  @override
  int get hashCode => Object.hash(id, description, category, date, amount, type);

}