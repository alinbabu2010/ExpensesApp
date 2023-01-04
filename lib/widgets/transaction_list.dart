import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteHandler;

  const TransactionList(this.transactions, this._deleteHandler, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 200,
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
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              var transaction = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: FittedBox(
                        child:
                            Text("₹${transaction.amount.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => _deleteHandler(transaction.id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
