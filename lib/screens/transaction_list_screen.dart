import 'package:flutter/material.dart';
import '../data/sample_transactions.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/balance_summary.dart';

//app home screen for Sprint 1: a scrollable list of transactions
//sourced from hardcoded sample data.
// stateless widget
class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = sampleTransactions();

    return Scaffold(
      appBar: AppBar(title: const Text('Xpense')),
      body: Column(
        children: [
          BalanceSummary(transactions: transactions),
          Expanded( //list will take the rest of room after siblings are sized
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionTile(transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}