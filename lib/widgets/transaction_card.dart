import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
    required Function deleteHandler,
  })  : _deleteHandler = deleteHandler,
        super(key: key);

  final Transaction transaction;
  final Function _deleteHandler;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.pink,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text("₹${transaction.amount.toStringAsFixed(2)}"),
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
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).errorColor)),
              )
            : IconButton(
          icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget._deleteHandler(transaction.id),
              ),
      ),
    );
  }
}
