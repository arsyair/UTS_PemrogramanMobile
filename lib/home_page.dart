import 'package:flutter/material.dart';
import 'currency_converter.dart';
import 'calculator_page.dart';
import 'login_page.dart';
import 'topup_page.dart';
import 'edit_profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double totalMoney = 1000000; // IDR
  double totalSavings = 500000; // IDR

  // Currency rates against IDR (example rates)
  final Map<String, double> currencyRates = {
    'USD': 15000.0,
    'EUR': 16000.0,
    'JPY': 100.0,
    'GBP': 19000.0,
    'AUD': 11000.0,
    'CAD': 12000.0,
  };

  // Current currency selection
  String selectedCurrency = 'IDR'; // Default currency is IDR (Indonesian Rupiah)

  // Currency options
  final List<String> currencies = ['IDR', 'USD', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD'];

  final TextEditingController withdrawController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _updateSavings(double amount) {
    setState(() {
      totalSavings += amount;
      totalMoney -= amount;
    });
  }

  void _withdraw() {
    double amount = double.tryParse(withdrawController.text) ?? 0.0;
    if (totalSavings >= amount && amount > 0) {
      setState(() {
        totalSavings -= amount;
        totalMoney += amount;
      });
      withdrawController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient funds or invalid input!')),
      );
    }
  }

  // Method to format and convert the amount based on the selected currency
  String _formatCurrency(double amount) {
    double convertedAmount = amount;

    if (selectedCurrency != 'IDR') {
      // Convert the amount from IDR to the selected currency
      convertedAmount = amount / currencyRates[selectedCurrency]!;
    }

    if (selectedCurrency == 'IDR') {
      return 'Rp ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'USD') {
      return '\$ ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'EUR') {
      return '€ ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'JPY') {
      return '¥ ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'GBP') {
      return '£ ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'AUD') {
      return 'A\$ ${convertedAmount.toStringAsFixed(2)}';
    } else if (selectedCurrency == 'CAD') {
      return 'C\$ ${convertedAmount.toStringAsFixed(2)}';
    } else {
      return amount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/RED.jpg'),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Arsyair',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'arsya.ilham@mhs.itenas.ac.id',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 21.57,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Edit Profile'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Arsyair!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[800]),
            ),
            SizedBox(height: 8),
            Text(
              'Check and manage your finances easily and quickly.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Currency dropdown moved below the "Check and manage your finances" text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Currency',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[800]),
                ),
                DropdownButton<String>(
                  value: selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCurrency = newValue!;
                    });
                  },
                  items: currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 1),

            // Financial info card
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              shadowColor: Colors.teal[300],
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFinancialInfo('Cash', totalMoney),
                    _buildFinancialInfo('Savings', totalSavings),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircleIcon(Icons.add, 'Top Up', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpPage(
                        onTopUp: _updateSavings,
                        totalMoney: totalMoney,
                      ),
                    ),
                  );
                }),
                _buildCircleIcon(Icons.remove, 'Withdraw', _withdraw),
                _buildCircleIcon(Icons.currency_exchange, 'Converter', () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CurrencyConverter()));
                }),
                _buildCircleIcon(Icons.calculate, 'Calculator', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorPage()));
                }),
              ],
            ),
            SizedBox(height: 18),
            TextField(
              controller: withdrawController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter withdrawal amount',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.money_off_csred, color: Colors.teal),
                filled: true,
                fillColor: Colors.teal[50],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialInfo(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: Colors.teal[700])),
        Text(
          _formatCurrency(amount),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[900]),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 35, color: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
