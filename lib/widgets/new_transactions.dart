import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  const NewTransaction({
    Key? key,
    required this.addTransactionHandler,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  /// To submit data to [widget.addTransactionHandler] using text editing controller
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text) ?? 0.0;
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTransactionHandler(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              textInputAction: TextInputAction.next,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // On iOS use 'const TextInputType.numberWithOptions(decimal: true)'
              // onChanged: (value) => amountInput = value,
            ),
            TextButton(
              onPressed: submitData,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.purple)),
              child: const Text("Add transaction"),
            )
          ],
        ),
      ),
    );
  }
}
