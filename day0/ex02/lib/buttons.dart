// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

List<String> operators = ['+', '-', '*', '/'];
var style_ = ButtonStyle(
  textStyle: MaterialStateProperty.all<TextStyle>(
    const TextStyle(color: Colors.white),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

List<Widget> array = [
  for (int i = 0; i < 10; i++)
    ElevatedButton(
      style: style_,
      onPressed: () {
        print('$i');
      },
      child: Text('$i'),
    ),
  ElevatedButton(
    style: style_,
    onPressed: () {
      print('.');
    },
    child: const Text('.'),
  ),
  ElevatedButton(
    style: style_,
    onPressed: () {
      print('AC');
    },
    child: const Text('AC'),
  ),
  ElevatedButton(
    style: style_,
    onPressed: () {
      print('C');
    },
    child: const Text('C'),
  ),
  ...operators.map(
    (operator) => ElevatedButton(
      style: style_,
      onPressed: () {
        print(operator);
      },
      child: Text(operator),
    ),
  ),
  ElevatedButton(
    style: style_,
    onPressed: () {
      print('=');
    },
    child: const Text('='),
  ),
];
