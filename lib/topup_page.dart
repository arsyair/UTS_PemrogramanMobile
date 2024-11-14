import 'package:flutter/material.dart';

class TopUpPage extends StatefulWidget {
  final Function(double) onTopUp;
  final double totalMoney;

  TopUpPage({required this.onTopUp, required this.totalMoney});

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController topUpController = TextEditingController();

  void _topUpSavings() {
    double topUpAmount = double.tryParse(topUpController.text) ?? 0.0;

    if (topUpAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Top-up amount must be greater than 0!')),
      );
      return;
    } else if (topUpAmount > widget.totalMoney) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Top-up amount exceeds the available funds!')),
      );
      return;
    }

    widget.onTopUp(topUpAmount);
    topUpController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up '),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      'Available Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rp ${widget.totalMoney.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.teal[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: topUpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Top-Up Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _topUpSavings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Top Up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
