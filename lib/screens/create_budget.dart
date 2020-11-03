import 'package:expenses/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class CreateBudgetScreen extends StatefulWidget {
  static const routeName = '/create-budget';

  @override
  _CreateBudgetScreenState createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  BudgetCategory _budgetCategory;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _amountNode = FocusNode();

  void _submit() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('TODO: Create budget.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        top: 20,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Create a budget'),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: EdgeInsets.fromLTRB(16, 5, 8, 5),
                child: Text(
                  'Select a category',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: _budgetCategory == category
                              ? BorderSide(
                                  color: Theme.of(context).accentColor,
                                )
                              : BorderSide(
                                  color: Colors.transparent,
                                ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _budgetCategory = category;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 150,
                            width: 150,
                            // padding: EdgeInsets.all(10),
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 5,
                              top: 10,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Icon(
                                    category.icon,
                                    size: 40,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Text(
                                  '$category',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: Theme.of(context).accentColor,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              enabled: _budgetCategory != null,
                              decoration: InputDecoration(
                                labelText: 'Budget name',
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_amountNode);
                              },
                              validator: (name) {
                                if (name.isEmpty) {
                                  return 'Enter a name.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              enabled: _budgetCategory != null,
                              focusNode: _amountNode,
                              decoration: InputDecoration(
                                labelText: 'Budget amount',
                                prefixText: '₦',
                              ),
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              textInputAction: TextInputAction.done,
                              onEditingComplete: _submit,
                              validator: (amount) {
                                if (amount.isEmpty) {
                                  return 'Enter an amount.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            FlatButton(
                              onPressed:
                                  _budgetCategory == null ? null : _submit,
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              child: Text('CREATE'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
