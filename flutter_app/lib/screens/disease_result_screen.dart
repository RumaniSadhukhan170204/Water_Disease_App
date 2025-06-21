import 'package:flutter/material.dart';

class DiseaseResultScreen extends StatelessWidget {
  const DiseaseResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as String?;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Prediction Result")),
        body: const Center(
          child: Text(
            "No prediction result found.",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    final Map<String, Map<String, String>> waterQualityInfo = {
      "Unsafe Water": {
        "risk": "High",
        "recommendation": "Avoid drinking. Use filtered/boiled water."
      },
      "Safe Water": {
        "risk": "None",
        "recommendation": "Water is safe for consumption."
      }
    };

    final info = waterQualityInfo[result]!;

    return Scaffold(
      appBar: AppBar(title: const Text("Water Quality Result")),
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
                  children: [
                    Text("Water Quality: $result",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Risk Level: ${info['risk']}",
                        style: TextStyle(
                          fontSize: 18,
                          color: info['risk'] == 'High'
                              ? Colors.red
                              : Colors.green,
                        )),
                    const SizedBox(height: 10),
                    Text(
                      "Recommendation: ${info['recommendation']}",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            ),
            if (result == "Unsafe Water")
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/alert'),
                icon: const Icon(Icons.warning),
                label: const Text("Send Alert"),
              ),
          ],
        ),
      ),
    );
  }
}
