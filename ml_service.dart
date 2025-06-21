import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'dart:math' as math;

class MLService {
  static late Interpreter _interpreter;

  /// Loads the TFLite model from assets
  static Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('model.tflite');
      print("✅ Model loaded successfully");
    } catch (e) {
      print("❌ Failed to load model: $e");
    }
  }

  /// Applies softmax to output logits
  static List<double> softmax(List<double> logits) {
    final maxLogit = logits.reduce(math.max);
    final exps = logits.map((x) => math.exp(x - maxLogit)).toList();
    final sumExps = exps.reduce((a, b) => a + b);
    return exps.map((x) => x / sumExps).toList();
  }

  /// Runs inference and returns predicted disease label
  static String predictDisease({
    required double ph,
    required double turbidity,
    required double tds,
    required double temp,
  }) {
    // Prepare input: [1, 4] shape
    final input = [
      [ph, turbidity, tds, temp]
    ];

    // Prepare output: [1, 2] shape for binary classification
    final output = List.filled(2, 0.0).reshape([1, 2]);

    try {
      _interpreter.run(input, output);
    } catch (e) {
      print("❌ Inference failed: $e");
      return "Error: Inference Failed";
    }

    // Debug: print input and raw model output
    print("📥 Input: $input");
    print("📤 Raw output: ${output[0]}");

    // Apply softmax if needed (optional)
    final List<double> probabilities = softmax(output[0]);
    print("🔁 Softmax probabilities: $probabilities");

    // Find the index with highest probability
    int maxIndex = 0;
    double maxProb = probabilities[0];
    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxIndex = i;
        maxProb = probabilities[i];
      }
    }

    // Label mapping
    final labels = [
      "Unsafe Water (Disease Risk)",
      "Safe Water",
    ];

    print("🧠 Prediction: ${labels[maxIndex]} with confidence: ${maxProb.toStringAsFixed(2)}");

    return labels[maxIndex];
  }
}