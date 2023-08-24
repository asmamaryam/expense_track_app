// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtransction extends StatefulWidget {
  final Function addtx;

  Newtransction(this.addtx);

  @override
  State<Newtransction> createState() => _NewtransctionState();
}

class _NewtransctionState extends State<Newtransction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selecteddate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _selecteddate == null) {
      return;
    }
    final enteredtitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || _selecteddate == null) {
      return;
    }
    ;

    widget.addtx(
      enteredtitle,
      enteredamount,
      _selecteddate,
    );
    Navigator.of(context).pop();
  }

  void _presentdataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        _selecteddate = pickeddate;
      });
    });
    print('..........');
  }

  @override
  Widget build(BuildContext context) {
    final keywords = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: keywords + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (val){
                //   titleinput = val;
                // },
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) => amountinput =value,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selecteddate == null
                            ? 'No Data Choosen'
                            : DateFormat.yMd().format(_selecteddate),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.amber,
                      ),
                      onPressed: _presentdataPicker,
                      child: Text('Choose Date'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text('Add Transcation'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
