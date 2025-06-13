import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController phController = TextEditingController();
  final TextEditingController turbidityController = TextEditingController();
  final TextEditingController tdsController = TextEditingController();
  final TextEditingController nitrateController = TextEditingController();
  final TextEditingController chlorineController = TextEditingController();
  final TextEditingController tempController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Disease Detector"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInputField("pH", phController),
            _buildInputField("Turbidity (NTU)", turbidityController),
            _buildInputField("TDS (ppm)", tdsController),
            _buildInputField("Nitrate (mg/L)", nitrateController),
            _buildInputField("Chlorine (mg/L)", chlorineController),
            _buildInputField("Temperature (°C)", tempController),
            const SizedBox(height: 20),
            CustomButton(
              text: "Analyze Water",
              onPressed: () {
                Navigator.pushNamed(context, '/result');
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
