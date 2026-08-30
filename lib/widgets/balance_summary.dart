// lib/widgets/balance_summary.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/transaction_summary.dart';

// Header showing total money in, total money out, and net balance,
// computed live from whatever transactions it's given.
class BalanceSummary extends StatelessWidget {
  final List<Transaction> transactions;

  const BalanceSummary({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryFigure(label: 'In', amount: transactions.totalIncome, color: Colors.green.shade700),
          _SummaryFigure(label: 'Out', amount: transactions.totalExpense, color: Colors.red.shade700),
          _SummaryFigure(
            label: 'Net',
            amount: transactions.netBalance,
            color: transactions.netBalance >= 0 ? Colors.green.shade700 : Colors.red.shade700,
          ),
        ],
      ),
    );
  }
}

class _SummaryFigure extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryFigure({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}