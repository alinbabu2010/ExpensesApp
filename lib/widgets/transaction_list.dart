import 'package:expenses_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteHandler;

  const TransactionList(this.transactions, this._deleteHandler, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          })
        : ListView(
            children: transactions
                .map((transaction) => TransactionCard(
                      key: ValueKey(transaction.id),
                      transaction: transaction,
                      deleteHandler: _deleteHandler,
                    ))
                .toList());
  }
}
