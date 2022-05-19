import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get gorupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
        print(recentTransactions[i].amount);
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get getWeekSpending {
    return gorupedTransactionsValues.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(gorupedTransactionsValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
    children: gorupedTransactionsValues
        .map(
          (e) => Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                e['day'],
                e['amount'],
                getWeekSpending == 0
                    ? 0.0
                    : (e['amount'] as double) / getWeekSpending),
          ),
        )
        .toList(),
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      );
  }
}
