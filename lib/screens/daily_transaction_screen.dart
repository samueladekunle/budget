import 'package:expenses/constants.dart';
import 'package:expenses/models/models.dart';
import 'package:expenses/screens/budget_category_screen.dart';
import 'package:expenses/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DailyTransactionScreen extends StatefulWidget {
  @override
  _DailyTransactionScreenState createState() => _DailyTransactionScreenState();
}

class _DailyTransactionScreenState extends State<DailyTransactionScreen> {
  static final _todaysDate = DateTime.now();
  static final _aYearAgo =
      DateTime(_todaysDate.year - 1, _todaysDate.month, _todaysDate.day);

  final _amount = 5000.00;
  final _categoriesSublist = categories.sublist(0, 5);

  Month _month = Month(number: _todaysDate.month, year: _todaysDate.year);
  List<Month> _monthRange = [];

  void _openBudgetCategory(BudgetCategory category) {
    final amount = _amount / _categoriesSublist.length.toDouble();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BudgetCategoryScreen(
          category: category,
          amount: amount,
          month: _month,
        );
      },
    );
  }

  Widget _buildCategoryListTile(BudgetCategory category, double amount) {
    return ListTile(
      leading: Icon(
        category.icon,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        '$category',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Text(numberFormat.format(amount)),
      onTap: () {
        _openBudgetCategory(category);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    for (int index = _aYearAgo.month; index <= DateTime.december; index++) {
      _monthRange.add(Month(number: index, year: _aYearAgo.year));
    }
    for (int index = DateTime.january; index <= _todaysDate.month; index++) {
      _monthRange.add(Month(number: index, year: _todaysDate.year));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width - 22,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineGraph(
                    amount: _amount,
                    month: _month,
                  ),
                ),
              ),
            ),
            Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                  ),
                  child: DropdownButton<Month>(
                    underline: Container(),
                    value: _month,
                    iconEnabledColor: Theme.of(context).accentColor,
                    items: _monthRange.map((month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text(
                          '$month',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (month) => setState(() => _month = month),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // padding: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                ..._categoriesSublist.map((category) {
                  final amount = _amount / _categoriesSublist.length.toDouble();
                  if (categories.indexOf(category) == categories.length - 1) {
                    return _buildCategoryListTile(category, amount);
                  }
                  return Column(
                    children: [
                      _buildCategoryListTile(category, amount),
                      Divider(
                        height: 0,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
