import 'package:flutter/material.dart';
import 'buttons.dart' as buttons;

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
  String userInput = '0';
  String calculatorOutput = '0';

  @override
  Widget build(BuildContext context) {
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
                          Text(userInput,
                              style: const TextStyle(
                                fontSize: 35,
                              )),
                          Text(calculatorOutput,
                              style: const TextStyle(
                                fontSize: 35,
                              )),
                        ]))),
            Expanded(
                flex: 2,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: GridView.count(
                      crossAxisCount: 5,
                      children: buttons.array,
                    ))),
          ],
        ),
      ),
    );
  }
}
