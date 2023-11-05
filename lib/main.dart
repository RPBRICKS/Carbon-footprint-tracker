import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Set dark theme for the entire app
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double textField1Value = 0.0;
  double textField2Value = 0.0;
  double textField3Value = 0.0;
  double textField4Value = 0.0;
  double textField5Value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Emission Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              hintText: 'Kilometers Driven (Petrol Car) 🚗',
              onChanged: (value) {
                setState(() {
                  textField1Value = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            _buildInputField(
              hintText: 'Gallons used for Shower (Hot) 🚿',
              onChanged: (value) {
                setState(() {
                  textField2Value = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            _buildInputField(
              hintText: 'Gallons of LPG used (Cooking gas) 🍳',
              onChanged: (value) {
                setState(() {
                  textField4Value = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            _buildInputField(
              hintText: 'Air conditioning (hours)',
              onChanged: (value) {
                setState(() {
                  textField3Value = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            _buildInputField(
              hintText: 'Data consumption (gb)',
              onChanged: (value) {
                setState(() {
                  textField5Value = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      textField1Value: textField1Value,
                      textField2Value: textField2Value,
                      textField3Value: textField3Value,
                      textField4Value: textField4Value,
                      textField5Value: textField5Value,
                    ),
                  ),
                );
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final double textField1Value;
  final double textField2Value;
  final double textField3Value;
  final double textField4Value;
  final double textField5Value;

  const SecondPage({
    Key? key,
    required this.textField1Value,
    required this.textField2Value,
    required this.textField3Value,
    required this.textField4Value,
    required this.textField5Value,
  }) : super(key: key);

  // Calculate the total carbon emissions
  double get totalCarbonEmissions =>
      (textField1Value * 180) +
      (textField2Value * 0.18) +
      (textField3Value * 285) +
      (textField4Value * 5680) +
      (textField5Value * 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Carbon Emission Statistics'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEmissionStatistic(
                'Car usage:',
                '${(textField1Value * 180).toStringAsFixed(2)}g',
              ),
              _buildEmissionStatistic(
                'Showering (hot):',
                '${(textField2Value * 0.18).toStringAsFixed(2)}g',
              ),
              _buildEmissionStatistic(
                'Air conditioning (hours):',
                '${(textField3Value * 285).toStringAsFixed(2)}g',
              ),
              _buildEmissionStatistic(
                'LPG usage:',
                '${(textField4Value * 5680).toStringAsFixed(2)}g',
              ),
              _buildEmissionStatistic(
                'Data consumption (gb):',
                '${(textField5Value * 300).toStringAsFixed(2)}g',
              ),
              Divider(), // Add a divider for separation
              _buildEmissionStatistic(
                'Total Carbon Emissions:',
                '${totalCarbonEmissions.toStringAsFixed(2)}g',
                isTotal: true, // Apply a different style to the total
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmissionStatistic(String label, String value,
      {bool isTotal = false}) {
    return InkWell(
      onTap: () {
        // Handle the tap here (you can add more interactivity)
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isTotal ? Colors.greenAccent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isTotal
              ? [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 5)]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    isTotal ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    isTotal ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
