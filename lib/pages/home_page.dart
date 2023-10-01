import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense/models/expense_item.dart';
import 'package:expense/components/expense_tile.dart';
import 'package:expense/components/expense_summary.dart';
import 'package:expense/data/expense_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newexpenseNameController = TextEditingController();
  final newexpenseDollarController = TextEditingController();
  final newexpenseCentsController = TextEditingController();
  @override
  void initState() {
    super.initState();

    //prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
              decoration: const InputDecoration(
                hintText: "Expense Name",
              ),
            ),
            //expense amount
            Row(
              children: [
                //dollars
                Expanded(
                  child: TextField(
                    controller: newexpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),
                Expanded(
                  child: //cents
                      TextField(
                          controller: newexpenseCentsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Cents",
                          )),
                ),
              ],
            )
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          //cancel button
          MaterialButton(
            onPressed: cancle,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

//delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save
  void save() {
    //only save expense if all fields are filled
    if (newexpenseNameController.text.isNotEmpty &&
        newexpenseDollarController.text.isNotEmpty &&
        newexpenseCentsController.text.isNotEmpty) {
      //put together dollars and cents
      String amount =
          '${newexpenseDollarController.text}.${newexpenseCentsController.text}';
      //create expense Item
      ExpenseItem newExpense = ExpenseItem(
        name: newexpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      ); //expenseItem
      // add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  //clear controller
  void clear() {
    newexpenseNameController.clear();
    newexpenseDollarController.clear();
    newexpenseCentsController.clear();
  }

  //cancle
  void cancle() {
    Navigator.pop(context);
  }

//expense List
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(children: [
            //weeklr summary
            ExpenseSummary(
              startOfWeek: value.startOfWeekDate() ?? DateTime.now(),
            ),
            const SizedBox(height: 20),
            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ), //ExpenseTile
            ),
          ])),
    );
  }
}
