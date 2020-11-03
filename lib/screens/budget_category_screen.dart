import 'package:budget/constants.dart';
import 'package:budget/models/models.dart';
import 'package:budget/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BudgetCategoryScreen extends StatelessWidget {
  final double amount;
  final Month month;
  final BudgetCategory category;

  const BudgetCategoryScreen({
    Key key,
    @required this.category,
    @required this.amount,
    @required this.month,
  }) : super(key: key);

  Widget _buildList() {
    return Column(
      children: List<Widget>.generate(5, (index) {
        if (index + 1 == 5) {
          return ListTile(
            title: Text(
              'Item ${index + 1}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(numberFormat.format(amount / 5)),
          );
        }
        return Column(
          children: [
            ListTile(
              title: Text(
                'Item ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Text(numberFormat.format(amount / 5)),
            ),
            Divider(
              height: 0,
              indent: 16,
              endIndent: 16,
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        top: 20,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            category.icon,
            color: Theme.of(context).accentColor,
          ),
          title: Text('$category'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineGraph(
                        amount: amount,
                        month: month,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildList(),
            ],
          ),
        ),
      ),
    );
  }
}
