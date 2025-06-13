import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NGO Notified")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 16),
              const Text("Notification Sent!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("NGO: WaterAid Foundation\nPhone: +91 9876543210\nLocation: 3.2 km away",
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              CustomButton(text: "Done", onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')))
            ],
          ),
        ),
      ),
    );
  }
}
