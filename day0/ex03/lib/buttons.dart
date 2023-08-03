// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CalculatorButtons {
  static var crossAxisCount = 5;

  static List<String> symbols_ = [
    '7', '8', '9', 'C', 'AC',
    '4', '5', '6', '+', '-',
    '1', '2', '3', 'x', '/',
    '0', '.', '00', '='
  ];

  static var style_ = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    ),
  );

  static var styleForEqualButton = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
    ),
  );

  static List<Widget> array(String userInput, String calculatorOutput) {
    return [
      ...symbols_.map(
        (operator) => ElevatedButton(
          style: style_,
          onPressed: () {
			  userInput += operator;
			  print(userInput);
          },
          child: Text(operator),
        ),
      ),
    ];
  }
}
