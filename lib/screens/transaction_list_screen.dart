import 'package:flutter/material.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';
import '../widgets/balance_summary.dart';
import '../widgets/transaction_tile.dart';
import 'transaction_form_screen.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TransactionRepository _repository = TransactionRepository();

  List<Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository.seedIfEmpty().then((_) => _loadTransactions());
  }

  Future<void> _loadTransactions() async {
    final transactions = await _repository.getAll();
    if (!mounted) return; // Check if the widget is still mounted before calling setState
    setState(() {
      _transactions = transactions;
      _isLoading = false;
    });
  }

  //opens the form and reloads if something was saved
  Future<void> _openForm({Transaction? transaction}) async {
    final saved = await Navigator.push<bool>( //"this route will pop with a bool, or null if it pops without one (back button)".
      context,
      MaterialPageRoute(
        builder: (_) => TransactionFormScreen(transaction: transaction),
      ),
    );
    if (saved == true) {
      _loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _openForm(), child: const Icon(Icons.add),
        ),

      appBar: AppBar(title: const Text('Xpense')),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                BalanceSummary(transactions: _transactions),
                Expanded( //give list rest of room on screen
                  child: ListView.builder(
                    itemCount: _transactions.length,

                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return Dismissible(
                        key: ValueKey(transaction.id),
                        direction: DismissDirection.endToStart,
                        background: Container( //bin icon
                          color: Colors.red.shade700,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) async { //1st delete from database
                          await _repository.delete(transaction.id!);
                          return true;
                        },
                        onDismissed: (_) {//2nd remove from list on screen
                          setState(() => _transactions.remove(transaction));
                        },
                        child: TransactionTile(
                          transaction: transaction,
                          onTap: () => _openForm(transaction: transaction),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

}