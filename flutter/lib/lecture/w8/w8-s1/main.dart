import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;
  final IconData icon; 

  const ExpenseItem({
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),

              ],
            ),
            const Spacer(), 

            Row(
              children: [
                Icon(icon, size: 20, color: Colors.black54),
                const SizedBox(width: 8),
                Text(
                  DateFormat.yMd().format(date), 
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("Expense Item Example")),
      body: ListView(
        children: [
          ExpenseItem(
            title: "Ronan The Best Book",
            amount: 15000.00,
            date: DateTime(2024, 11, 9),
            icon: Icons.book, 
          ),
          ExpenseItem(
            title: "House",
            amount: 80000.00,
            date: DateTime(2024, 11, 9),
            icon: Icons.house, 
          ),
        ],
      ),
    ),
  ));
}
