// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unused_field

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  late DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
              ),
              Container(
                height: 70,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('dd/MM/y').format(_selectedDate),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text('Nova Transação'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button!.color,
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
