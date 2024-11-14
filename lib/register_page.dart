import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? birthDate; // Variabel untuk menyimpan tanggal lahir
  bool isMale = false; // For Male checkbox
  bool isFemale = false; // For Female checkbox

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked; // Update tanggal lahir
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username TextField
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 10),

              // Password TextField
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),

              // Date of Birth Picker
              TextField(
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  hintText: birthDate != null ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}' : 'Pilih Tanggal',
                ),
              ),
              SizedBox(height: 20),

              // Gender Selection (Checkbox)
              Text('Gender:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Checkbox(
                    value: isMale,
                    onChanged: (bool? value) {
                      setState(() {
                        isMale = value!;
                        if (isMale) {
                          isFemale = false; // Uncheck female if male is selected
                        }
                      });
                    },
                  ),
                  Text('Male'),
                  SizedBox(width: 20),
                  Checkbox(
                    value: isFemale,
                    onChanged: (bool? value) {
                      setState(() {
                        isFemale = value!;
                        if (isFemale) {
                          isMale = false; // Uncheck male if female is selected
                        }
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  // Logic for registration can be added here
                  Navigator.pop(context);
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 141, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
