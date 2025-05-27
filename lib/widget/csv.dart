
 import 'package:flutter/material.dart';

Widget buildActionButton(String text) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
             gradient: LinearGradient(
        colors: [Colors.blue.shade800, Colors.indigo.shade400],
                //  colors: [const Color.fromARGB(255, 99, 106, 189), const Color.fromARGB(255, 101, 165, 191)],
                   begin: Alignment.topLeft,
                       end: Alignment.bottomRight
                         ),
   
            border: Border.all(color: const Color.fromARGB(255, 133, 94, 199)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }