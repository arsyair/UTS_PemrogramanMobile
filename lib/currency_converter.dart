import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'USD';
  bool addTax = false;
  double result = 0.0;

  // Daftar kurs mata uang terhadap IDR (contoh)
  final Map<String, double> currencyRates = {
    'USD': 15000.0,
    'EUR': 16000.0,
    'JPY': 100.0,
    'GBP': 19000.0,
    'AUD': 11000.0,
    'CAD': 12000.0,
  };

  void _convertCurrency() {
    double amount = double.tryParse(amountController.text) ?? 0;
    double rate = currencyRates[selectedCurrency] ?? 1;
    result = amount * rate;

    if (addTax) result *= 1.1; // Tambahan pajak 10%
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converter'),
        backgroundColor: Colors.teal,
        actions: [
          Icon(Icons.currency_exchange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Input Nominal',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Choose Currency',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 0),
                    DropdownButton<String>(
                      value: selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                      isExpanded: true,
                      items: currencyRates.keys.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 0),
                    CheckboxListTile(
                      title: Text('Add Tax 10%'),
                      value: addTax,
                      onChanged: (bool? value) {
                        setState(() {
                          addTax = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: _convertCurrency,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Convert',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 7),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.teal[50],
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Result',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${result.toStringAsFixed(2)} IDR',
                      style: TextStyle(fontSize: 24, color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
