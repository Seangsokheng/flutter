import 'package:flutter/material.dart';
import 'package:week3/w9/w9-s2/1%20-%20Code%20Grocery%20-%20Start/widgets/new_item.dart';
import '../data/dummy_items.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) {
          final item = dummyGroceryItems[index];
          return ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: item.category.color,
            ),
            title: Text(item.name),
            trailing: Text(item.quantity.toString()),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed:()  {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewItem()),
                );
              },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
