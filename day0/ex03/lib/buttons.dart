// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class DisplayStreamWrapper {
  String input;
  num output;

  DisplayStreamWrapper({required this.input, required this.output});
}

void calculatorHandler(String operator_, DisplayStreamWrapper display) {
  print('output:' + display.input);
  switch (operator_) {
    case '=':
  	  print('output:' + display.output.toString());
      display.output = display.input.interpret();
      print(display.output);
    case 'AC':
      display.input = '0';
      display.output =
          0; // Change 0 to '0' as display.output is of type String.
    case 'C':
      if (display.input.length > 1) {
        display.input = display.input.substring(0, display.input.length - 1);
      } else {
        display.input = '0';
      }
    case '0':
      if (display.input == '0' &&
          int.parse(operator_) >= 1 &&
          int.parse(operator_) <= 9) {
        display.input = operator_;
      } else if (display.input == '0' && operator_ == '0') {
        return;
      } else {
        display.input = '$display.input$display.operator';
      }
    default:
      if (display.input == '0') {
        display.input = operator_;
      } else {
        display.input = '$display.input$display.operator';
      }
  }
}

class CalculatorButtons {
  static var crossAxisCount = 5;

  static List<String> symbols_ = [
    '7',
    '8',
    '9',
    'C',
    'AC',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    'x',
    '/',
    '0',
    '.',
    '00',
    '=',
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

  static List<Widget> array(
      Function() setStateCallBack, DisplayStreamWrapper displayStream) {
    return [
      ...symbols_.map(
        (operator_) => ElevatedButton(
          style: style_,
          onPressed: () {
            setStateCallBack;
            calculatorHandler(operator_, displayStream);
          },
          child: Text(operator_),
        ),
      ),
    ];
  }
}
