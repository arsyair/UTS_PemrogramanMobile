import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String displayText = "";

  void buttonPressed(String value) {
    setState(() {
      displayText += value; // Menambahkan angka atau operasi yang ditekan ke tampilan
    });
  }

  void calculateResult() {
    // Menggunakan math_expressions untuk menghitung hasil
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(displayText);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      displayText = result.toString();
    } catch (e) {
      displayText = "Error"; // Menangani error
    }
    setState(() {});
  }

  void clear() {
    setState(() {
      displayText = ""; // Menghapus tampilan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tampilan hasil kalkulasi
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              displayText,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              // Baris pertama
              buildButtonRow(["7", "8", "9", "/"], operatorColor: Colors.orange),
              buildButtonRow(["4", "5", "6", "*"], operatorColor: Colors.orange),
              buildButtonRow(["1", "2", "3", "-"], operatorColor: Colors.orange),
              buildButtonRow(["C", "0", "=", "+"], operatorColor: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String value, {Color color = Colors.teal, Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () {
        if (value == "C") {
          clear();
        } else if (value == "=") {
          calculateResult();
        } else {
          buttonPressed(value);
        }
      },
      child: Text(
        value,
        style: TextStyle(fontSize: 24, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: color,
      ),
    );
  }

  Widget buildButtonRow(List<String> values, {Color operatorColor = Colors.blue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values.map((value) {
          bool isOperator = ["+", "-", "*", "/", "="].contains(value);
          Color buttonColor = isOperator ? operatorColor : Colors.teal;
          Color textColor = isOperator ? Colors.white : Colors.white;
          return buildButton(value, color: buttonColor, textColor: textColor);
        }).toList(),
      ),
    );
  }
}
