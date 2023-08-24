import 'package:expense_track_app/widgets/charts_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class Charts extends StatelessWidget {
  final List<Trascation> recenttransction;

  Charts(this.recenttransction);

  List<Map<String, Object>> get groupedTransactionvalue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.0;
      for (var i = 0; i < recenttransction.length; i++) {
        if (recenttransction[i].date.day == weekday.day &&
            recenttransction[i].date.month == weekday.month &&
            recenttransction[i].date.year == weekday.year) {
          totalsum = totalsum + recenttransction[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalsum);

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalspending {
    return groupedTransactionvalue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionvalue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionvalue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chartbar(
                  data['day'].toString(),
                  data['amount'] as double,
                  totalspending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
