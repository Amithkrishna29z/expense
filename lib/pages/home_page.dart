import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense/models/expense_item.dart';
import 'package:expense/data/expense_data.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newexpenseNameController = TextEditingController();
  final newexpenseAmountController = TextEditingController();

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newexpenseNameController,
            ),
            //expense amount
            TextField(
              controller: newexpenseAmountController,
            ),
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          //cancel button
          MaterialButton(
            onPressed: cancle,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // save
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newexpenseNameController.text,
      amount: newexpenseAmountController.text,
      dateTime: DateTime.now(),
    ); //expenseItem
    // add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
  }

  //cancle
  void cancle() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.getAllExpenseList().length,
          itemBuilder: (context, index) =>
              ListTile(title: Text(value.getAllExpenseList()[index].name)),
        ),
      ),
    );
  }
}
