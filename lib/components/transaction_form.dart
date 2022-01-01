// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              controller: valueController,
            ),
            Container(
              height: 70,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text('Nenhuma data selecionada!'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
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
    );
  }
}
