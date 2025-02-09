import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';  // Import math expression evaluator

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  String output = "0"; // Displayed result
  String expression = ""; // Expression to evaluate

  void buttonPressed(String buttonText) {
    if (buttonText == "Clear") {
     setState(() {
       expression = "";
       output = "0";
     });
    } else if (buttonText == "=") {
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        setState(() {
          output = eval.toString();
        });
      } catch (e) {
        setState(() {
          output = "Error";
        });
      }
    } else {
      setState(() {
        expression += buttonText;
        output = expression;  // Update the displayed expression
      });
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: OutlinedButton(
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () => buttonPressed(buttonText),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("."),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("Clear"),
                  buildButton("="),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
