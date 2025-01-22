import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(label: "Submit", icon: Icons.check ),
              SizedBox(height: 20,),
              CustomButton(label: "Time", icon: Icons.punch_clock, position: IconPosition.right,buttonType: Button.secondary, ),
              SizedBox(height: 20,),
              CustomButton(label: "Bank", icon: Icons.account_balance_sharp, position: IconPosition.right, buttonType: Button.disabled, ),
            ],
          ),
        ),
      ),
    ),
  );
}

enum Button {
  primary,
  secondary,
  disabled,
}

extension Type on Button {
  Color get color {
    switch (this) {
      case Button.primary:
        return Colors.blue;
      case Button.secondary:
        return Colors.green;
      case Button.disabled:
        return Colors.grey;
    }
  }
}

enum IconPosition {
  left,
  right,
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition position;
  final Button buttonType;
  const CustomButton(
      {required this.label,
      required this.icon,
      this.position = IconPosition.left,
      this.buttonType = Button.primary,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonType.color,
        ),
        child: Center(
          child: Row(
            children: position == IconPosition.left
            ? [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: Icon(
                  icon,
                ),
              ),
              Text(
                label,
              ),
            ]:
            [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: Text(
                label,
                ),
              ), 
              Icon(
                  icon,
                ),
            ]
          ),
        ),
      ),
    );
  }
}
