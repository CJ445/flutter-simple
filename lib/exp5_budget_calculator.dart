// Exp 5: Personal Budget Calculator - state management with Provider.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetModel extends ChangeNotifier {
  double income = 0;
  List names = [];
  List<double> amounts = [];

  double get total => amounts.fold(0.0, (a, b) => a + b);
  double get balance => income - total;
  String get status => income == 0
      ? 'Enter your income'
      : balance < 0
      ? 'Over Budget'
      : balance < income * 0.2
      ? 'Low Savings'
      : 'Healthy Budget';

  void setIncome(double v) {
    income = v;
    notifyListeners();
  }

  void add(String n, double a) {
    names.add(n);
    amounts.add(a);
    notifyListeners();
  }

  void remove(int i) {
    names.removeAt(i);
    amounts.removeAt(i);
    notifyListeners();
  }
}

void main() {
  var incomeCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var amountCtrl = TextEditingController();

  runApp(
    ChangeNotifierProvider(
      create: (_) => BudgetModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Personal Budget Calculator')),
          body: Consumer<BudgetModel>(
            builder: (context, b, child) {
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: incomeCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Income (₹)'),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Set'),
                        onPressed: () =>
                            b.setIncome(double.parse(incomeCtrl.text)),
                      ),
                    ],
                  ),
                  Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Income\n₹${b.income.toInt()}'),
                            Text('Expenses\n₹${b.total.toInt()}'),
                            Text('Balance\n₹${b.balance.toInt()}'),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: b.income == 0
                              ? 0
                              : (b.total / b.income).clamp(0, 1).toDouble(),
                        ),
                        Text(b.status),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameCtrl,
                          decoration: InputDecoration(labelText: 'Expense'),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: amountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Amount'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          b.add(nameCtrl.text, double.parse(amountCtrl.text));
                          nameCtrl.clear();
                          amountCtrl.clear();
                        },
                      ),
                    ],
                  ),
                  for (int i = 0; i < b.names.length; i++)
                    ListTile(
                      title: Text(b.names[i]),
                      subtitle: Text('₹${b.amounts[i].toInt()}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => b.remove(i),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}
