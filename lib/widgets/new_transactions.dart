import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransactionHandler;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction({Key? key, required this.addTransactionHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amountController,
              // onChanged: (value) => amountInput = value,
            ),
            TextButton(
              onPressed: () {
                addTransactionHandler(
                  titleController.text,
                  double.parse(amountController.text),
                );
              },
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
