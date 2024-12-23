import 'package:flutter/material.dart';
import 'package:week3/1-START%20CODE/models/course.dart';

class ScoreForm extends StatefulWidget {
  const ScoreForm({super.key});

  @override
  State<ScoreForm> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredSocre = 1;

  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      Navigator.pop(context);
    }
  }

  String? validateSocre(String? value) {
    final quantity = int.tryParse(value ?? '');
    if (quantity == null || quantity <= 0 || quantity > 100) {
      return 'The socre between 0 to 100.';
    }
    return null;
  }

  String? validateTitle(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sorce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _enteredSocre.toString(),
                      decoration: const InputDecoration(
                        label: Text('Socre'),
                      ),
                      validator: validateSocre,
                      onSaved: (value) {
                        _enteredSocre = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _saveItem,
                child:const Text('Add Socre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
