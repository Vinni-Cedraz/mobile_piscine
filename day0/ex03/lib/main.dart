// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'buttons.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
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
  DisplayStreamWrapper displayStream = DisplayStreamWrapper(
    input: 'hello world',
    output: 1232345,
  );

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
                          Text(displayStream.input,
                              style: const TextStyle(
                                fontSize: 35,
                              )),
                          Text(displayStream.output.toString(),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 5,
                        ),
                        children: CalculatorButtons.array((() {
                        }), displayStream),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
