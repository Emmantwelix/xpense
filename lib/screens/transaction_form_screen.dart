import 'package:flutter/material.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';

// Add a new transaction when transaction is null or edit an existing
// one when it isn't. 
// One screen for both, the only differences are
// what the fields start out holding and whether saving inserts or updates.
class TransactionFormScreen extends StatefulWidget {
  final Transaction? transaction;

  const TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

//state
class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransactionRepository _repository = TransactionRepository();

  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;
  late final TextEditingController _amountController;
  late DateTime _date;
  late TransactionType _type;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.transaction;
    _descriptionController = TextEditingController(text: existing?.description ?? '');
    _categoryController = TextEditingController(text: existing?.category ?? '');
    _amountController = TextEditingController(
      text: existing != null ? existing.amount.toStringAsFixed(2) : '',
    );
    _date = existing?.date ?? DateTime.now();
    _type = existing?.type ?? TransactionType.expense;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _categoryController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null || !mounted) return;
    setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return; //validate

    final transaction = Transaction(
      id: widget.transaction?.id,
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim(),
      date: _date,
      amount: double.parse(_amountController.text),
      type: _type,
    );

    if (_isEditing) {
      await _repository.update(transaction);
    } else {
      await _repository.insert(transaction);
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit transaction' : 'Add transaction'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Enter a description' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Enter a category' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount', prefixText: '\$'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                if (parsed == null || parsed <= 0) return 'Enter an amount greater than 0';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TransactionType>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: 'Type'),
              items: TransactionType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _type = value);
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date'),
              subtitle: Text(MaterialLocalizations.of(context).formatMediumDate(_date)),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}