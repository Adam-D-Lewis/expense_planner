import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  late final Function addTx;

  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;  
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: "Title"),
          // onChanged: (title) {
          //   titleInput = title;
          // },
          controller: _titleController,
          onSubmitted: (_) => _submitData(),
        ),
        TextField(
          decoration: InputDecoration(labelText: "Amount"),
          // onChanged: (amount) {
          //   amountInput = amount;
          // },
          controller: _amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _submitData(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                _selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Transaction Date: ${DateFormat.yMd().format(_selectedDate).toString()}',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                primary: Theme.of(context).primaryColor,
              ),
              child: Text('Choose Date'),
              onPressed: _presentDatePicker,
            )
          ],
        ),
        ElevatedButton(
          onPressed: _submitData,
          child: Text('Add Transaction'),
        ),
      ]),
    );
  }
}
