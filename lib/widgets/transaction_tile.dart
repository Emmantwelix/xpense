import 'package:flutter/material.dart';
import '../models/transaction.dart';

/// Renders a single [Transaction] as one row in a list.
/// Purely presentational: it owns no state and reaches for nothing
/// beyond the Transaction it's given.
class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction}); //const: skip rebuilding the widget if nothing changes

  static const _monthAbbreviations = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime date) {
    return '${_monthAbbreviations[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? Colors.green.shade700 : Colors.red.shade700;
    final sign = isIncome ? '+' : '-';

    return ListTile(
      leading: Icon(
        isIncome ? Icons.arrow_upward : Icons.arrow_downward,
        color: amountColor,
      ),
      title: Text(
        transaction.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('${transaction.category} · ${_formatDate(transaction.date)}'),
      trailing: Text(
        '$sign\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}