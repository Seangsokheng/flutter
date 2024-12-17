import 'package:flutter/material.dart';
import 'package:week3/lecture/w10/1%20-Item%20Name%20Validation/widgets/grocery_list.dart';
import 'package:week3/lecture/w8/w8-s2/inClass/models/expense.dart';
import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({required this.mode, this.initialItem, super.key});

  final GroceryItem? initialItem;
  final Mode mode;
  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredQuantity = 1;
  GroceryCategory _selectedCategory = GroceryCategory.fruit;
  void _saveItem() {
    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      // 2 - Save the form to get last entered values
      _formKey.currentState!.save();

      Navigator.pop<GroceryItem>(
          context,
          GroceryItem(
            id: uuid.v1(),
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory,
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.mode == Mode.edit && widget.initialItem != null) {
    
      setState(() {
        _enteredName = widget.initialItem!.name;
        _enteredQuantity = widget.initialItem!.quantity;
        _selectedCategory = widget.initialItem!.category;
      });
    }
  }

  void _resetForm() {
    // TODO: reset the form
    _formKey.currentState!.reset();
  }

  String? validateQuantity(String? value) {
    final quantity = int.tryParse(value ?? '');
    if (quantity == null || quantity <= 0) {
      return 'Must be a valid, positive number.';
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
        title:
            Text(widget.mode == Mode.create ? 'Add a new item' : 'Edit Item'),
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
                      initialValue: _enteredQuantity.toString(),
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      validator: validateQuantity,
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: widget.mode == Mode.edit
                        ? widget.initialItem?.category
                        : _selectedCategory,
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text(widget.mode == Mode.create ? 'Add' : 'Edit'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
