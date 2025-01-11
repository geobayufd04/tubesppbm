import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _celsiusController = TextEditingController();
  String _result = "";

  void convertToFahrenheit() {
    if (_celsiusController.text.isEmpty) {
      setState(() {
        _result = 'Please enter a temperature';
      });
      return;
    }

    double celsius = double.tryParse(_celsiusController.text) ?? 0;
    double fahrenheit = (celsius * 9 / 5) + 32;
    setState(() {
      _result = '$fahrenheit °F';
    });
  }

  void convertToCelsius() {
    if (_celsiusController.text.isEmpty) {
      setState(() {
        _result = 'Please enter a temperature';
      });
      return;
    }

    double fahrenheit = double.tryParse(_celsiusController.text) ?? 0;
    double celsius = (fahrenheit - 32) * 5 / 9;
    setState(() {
      _result = '$celsius °C';
    });
  }

  void reset() {
    _celsiusController.clear();
    setState(() {
      _result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('Temperature Converter', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            controller: _celsiusController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Temperature',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: convertToFahrenheit,
                child: const Text('To Fahrenheit'),
              ),
              ElevatedButton(
                onPressed: convertToCelsius,
                child: const Text('To Celsius'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: reset,
            child: const Text('Reset'),
          ),
          const SizedBox(height: 20),
          Text('Result: $_result', style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}