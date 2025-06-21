import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../services/ml_service.dart';
import '../screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController phController = TextEditingController();
  final TextEditingController turbidityController = TextEditingController();
  final TextEditingController tdsController = TextEditingController();
  final TextEditingController tempController = TextEditingController();

  bool _isModelLoaded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadModelAsync();
  }

  Future<void> _loadModelAsync() async {
    try {
      await MLService.loadModel();
      setState(() {
        _isModelLoaded = true;
        _isLoading = false;
      });
    } catch (e) {
      print("❌ Failed to load model: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void analyzeWater() {
    final ph = double.tryParse(phController.text) ?? 7.0;
    final turbidity = double.tryParse(turbidityController.text) ?? 1.0;
    final tds = double.tryParse(tdsController.text) ?? 300;
    final temp = double.tryParse(tempController.text) ?? 25;

    final prediction = MLService.predictDisease(
      ph: ph,
      turbidity: turbidity,
      tds: tds,
      temp: temp,
    );

    Navigator.pushNamed(context, '/result', arguments: prediction);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Disease Detector"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInputField("pH", phController),
            _buildInputField("Turbidity (NTU)", turbidityController),
            _buildInputField("TDS (ppm)", tdsController),
            _buildInputField("Temperature (°C)", tempController),
            const SizedBox(height: 20),
            CustomButton(
              text: "Analyze Water",
              onPressed: _isModelLoaded ? analyzeWater : null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
