import 'package:flutter/material.dart';
void main() {
  runApp(
    MaterialApp(
      home:Center(
          child: Column(children: [
            const SizedBox(height: 100,),
            Container(
              height: 200,
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    width: 100,
                    color: const Color.fromARGB(255, 6, 42, 71),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child:Container(
                    color: Colors.green,
                  ), 
                  ),
                  
                  Container(
                    width: 100,
                    color: Colors.pink,
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                color: Colors.pink,
              ),
            ),
      ])),
    ),
  );
}