import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        var recentTransactionDate = recentTransactions[i].date;
        if (recentTransactionDate.day == weekDay.day &&
            recentTransactionDate.month == weekDay.month &&
            recentTransactionDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  const Chart({required this.recentTransactions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            var totalPercentageSpending = totalSpending == 0.0
                ? 0.0
                : (data['amount'] as double) / totalSpending;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'].toString(),
                data['amount'] as double,
                totalPercentageSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
