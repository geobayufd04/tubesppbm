import 'package:flutter/material.dart';
import 'package:tubesppbm/Screens/temperature_converter.dart'; // Pastikan jalur ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator and Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  final TextEditingController _controller = TextEditingController();

  void buttonPressed(String value) {
    setState(() {
      input += value;
      _controller.text = input; // Update the controller text
    });
  }

  void clear() {
    setState(() {
      input = "";
      _controller.text = input; // Update the controller text
    });
  }

  void calculate() {
    try {
      // Simple evaluation logic
      final result = _evaluateExpression(input);
      setState(() {
        input = result.toString();
        _controller.text = input; // Update the controller text
      });
    } catch (e) {
      setState(() {
        input = "Error";
        _controller.text = input; // Update the controller text
      });
    }
  }

  double _evaluateExpression(String expression) {
    // Basic implementation for evaluating simple expressions
    try {
      List<String> parts = expression.split(RegExp(r'(\+|\-|\*|\/)'));
      double result = double.parse(parts[0]);

      for (int i = 1; i < parts.length; i += 2) {
        String operator = parts[i];
        double nextValue = double.parse(parts[i + 1]);

        switch (operator) {
          case '+':
            result += nextValue;
            break;
          case '-':
            result -= nextValue;
            break;
          case '*':
            result *= nextValue;
            break;
          case '/':
            result /= nextValue;
            break;
        }
      }
      return result;
    } catch (e) {
      return 0; // Return 0 if there's an error in evaluation
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('Calculator', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            style: const TextStyle(fontSize: 32),
            readOnly: true,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              ...[
                '1',
                '2',
                '3',
                'C',
                '4',
                '5',
                '6',
                '+',
                '7',
                '8',
                '9',
                '-',
                '0',
                '.',
                '=',
                '/'
              ]
                  .map((e) => Padding(
                padding: const EdgeInsets.all(8.0), // Add padding around buttons
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0), // Adjust padding
                    textStyle: const TextStyle(fontSize: 24), // Adjust font size
                  ),
                  onPressed: () {
                    if (e == "=") {
                      calculate();
                    } else if (e == "C") {
                      clear();
                    } else {
                      buttonPressed(e);
                    }
                  },
                  child: Text(e),
                ),
              ))
                  .toList(),
            ],
          ),
          const Divider(height: 40), // Add a divider between calculator and temperature converter
          const TemperatureConverter(), // Add the temperature converter widget
        ],
      ),
    );
  }
}