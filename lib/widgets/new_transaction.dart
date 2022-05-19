import 'dart:io';

import 'package:expenses_app/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (amount <= 0 || title.isEmpty || selectedDate == null) return;

    widget.addTx(titleController.text, amount, selectedDate);

    Navigator.of(context).pop();
  }

  _presendDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickDate) => {
          if (pickDate != null)
            {
              setState(() {
                selectedDate = pickDate;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                child: Row(
                  children: [
                    selectedDate != null
                        ? Text(DateFormat.yMd().format(selectedDate).toString())
                        : Text('No date chosen!'),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presendDatePicker,
                      child: Text('Chose date'),
                    ),
                  ],
                ),
              ),
              AdaptiveButton(
                'Add to list',
                submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
