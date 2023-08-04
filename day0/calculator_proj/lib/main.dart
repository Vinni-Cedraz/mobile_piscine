// ignore_for_file: avoid_print

import 'package:function_tree/function_tree.dart';
import 'package:flutter/material.dart';

class DisplayStreamWrapper {
  String input;
  num output;
  DisplayStreamWrapper({required this.input, required this.output});
}

var crossAxisCount = 5;

var style_ = ButtonStyle(
  textStyle: MaterialStateProperty.all<TextStyle>(
    const TextStyle(fontSize: 30),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),
);

List<String> symbols_ = [
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
  '*',
  '/',
  '0',
  '.',
  '00',
  '=',
  ' ',
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = '0';
  num output = 0;

  void calculatorHandler(String operator_) {
    setState(() {
      switch (operator_) {
        case ' ':
          return;
        case '=':
          output = input.interpret();
          break;
        case 'AC':
          input = '0';
          output = 0; // Change 0 to '0' as output is of type String.
          break;
        case 'C':
          if (input.length > 1) {
            input = input.substring(0, input.length - 1);
          } else {
            input = '0';
          }
          break;
        case '0':
          if (input == '0' &&
              int.parse(operator_) >= 1 &&
              int.parse(operator_) <= 9) {
            input = operator_;
          } else if (input == '0' && operator_ == '0') {
            return;
          } else {
            input = '$input$operator_';
          }
          break;
        default:
          if (input == '0') {
            input = operator_;
          } else {
            input = '$input$operator_';
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (((MediaQuery.of(context).size.height - kToolbarHeight - 24))) / 3.05;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(input,
                              style: const TextStyle(
                                fontSize: 35,
                              )),
                          Text(output.toString(),
                              style: const TextStyle(
                                fontSize: 35,
                              )),
                        ]))),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          kToolbarHeight * 0.5,
                      child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 5,
                          ),
                          children: [
                            ...symbols_.map(
                              (operator_) => ElevatedButton(
                                style: style_,
                                onPressed: () {
                                  calculatorHandler(operator_);
                                },
                                child: Text(operator_),
                              ),
                            ),
                          ]),
                    ))),
          ],
        ),
      ),
    );
  }
}
