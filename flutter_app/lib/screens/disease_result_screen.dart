import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class DiseaseResultScreen extends StatelessWidget {
  const DiseaseResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text("Detected Disease: Cholera",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Risk Level: High", style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 10),
                    Text("Recommendation: Boil water before drinking.")
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Notify NGO",
              onPressed: () {
                Navigator.pushNamed(context, '/alert');
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: "Back to Home",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
