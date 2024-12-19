import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const CategoryIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.orangeAccent,
            size: 30,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black54),
        ),
      ],
    );
  }
}