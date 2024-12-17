import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

enum Mode {
  create,
  edit,
}

class _GroceryListState extends State<GroceryList> {

  Future<void> _addItem(
    BuildContext context, Mode mode, GroceryItem? item) async {
    final GroceryItem? result = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
          builder: (context) => NewItem(
                mode: mode,
                initialItem: item,
          )),
    );
    if (result != null) {
      setState(() {
        if (mode == Mode.create) {
          dummyGroceryItems.add(result);
        } else {
          final index = dummyGroceryItems.indexOf(item!);
          if (index != -1) {
            dummyGroceryItems[index] = result;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(
          dummyGroceryItems[index],
          onEdit: () => _addItem(context, Mode.edit, dummyGroceryItems[index]),
          ),
        
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context, Mode.create, null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(this.groceryItem,{super.key , required this.onEdit});

  final GroceryItem groceryItem;
  final VoidCallback onEdit; 
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(groceryItem.name),
        leading: Container(
          width: 24,
          height: 24,
          color: groceryItem.category.color,
        ),
        trailing: Text(
          groceryItem.quantity.toString(),
        ),
        onTap: onEdit,
      );
  }
}
