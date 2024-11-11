import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: const Center(
          child :Column(
            children: [
              SelectButton(),
              SizedBox(height: 20,),
              SelectButton(),
              SizedBox(height: 20,),
              SelectButton(),
              SizedBox(height: 20,),
              SelectButton(),
            ],
          )
          
        ),
      ),
    ));

class SelectButton extends StatefulWidget {
  const SelectButton({super.key});

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  bool selected = false;
  String title = "Not selected";
  Color textColor = Colors.black;
  Color? backgroundColor = Colors.blue[50];

  void selectAction() {
    setState(() {
      if (!selected) {
        title = "Selected";
        textColor = Colors.white;
        backgroundColor = Colors.blue[500];
        selected = true;
      } else {
        title = "Not selected";
        textColor = Colors.black;
        backgroundColor = Colors.blue[50];
        selected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: selectAction,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
