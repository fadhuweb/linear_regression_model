import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/dropdown_options.dart'; // ✅ Import dropdown values

class PredictScreen extends StatefulWidget {
  const PredictScreen({Key? key}) : super(key: key);

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController plantingYearController = TextEditingController();
  final TextEditingController harvestYearController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController productionController = TextEditingController();

  // Dropdown selections
  String? selectedCountry = countryOptions.first;
  String? selectedAdmin = admin1Options.first;
  String? selectedProduct = productOptions.first;
  String? selectedSeason = seasonOptions.first;
  String? selectedSystem = systemOptions.first;
  String? selectedPlantingMonth = monthOptions.first;
  String? selectedHarvestMonth = monthOptions[4];

  String? predictionResult;
  bool isLoading = false;

  Future<void> predictYield() async {
    if (!_formKey.currentState!.validate()) return;

    final plantingYear = int.tryParse(plantingYearController.text);
    final harvestYear = int.tryParse(harvestYearController.text);
    final plantingMonth = int.parse(selectedPlantingMonth!.split(' - ')[0]);
    final harvestMonth = int.parse(selectedHarvestMonth!.split(' - ')[0]);

    // Logical validation: planting must be before harvest
    if (harvestYear! < plantingYear! ||
        (harvestYear == plantingYear && harvestMonth <= plantingMonth)) {
      setState(() {
        predictionResult = "❌ Error: Harvest date must be after planting date.";
      });
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse('https://linear-regression-model-4-49xg.onrender.com/predict');

    final body = {
      'country': selectedCountry,
      'admin_1': selectedAdmin,
      'product': selectedProduct,
      'season_name': selectedSeason,
      'planting_year': plantingYear,
      'planting_month': plantingMonth,
      'harvest_year': harvestYear,
      'harvest_month': harvestMonth,
      'crop_production_system': selectedSystem,
      'area': double.parse(areaController.text),
      'production': double.parse(productionController.text),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() =>
            predictionResult = "✅ Predicted Yield: ${result['predicted_yield']}");
      } else {
        final err = jsonDecode(response.body);
        final detail = err['detail'];
        final message = detail is List
            ? detail.map((e) => e['msg']).join('\n')
            : detail.toString();
        setState(() => predictionResult = "❌ Error: $message");
      }
    } catch (e) {
      setState(() => predictionResult = "❌ Network error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    plantingYearController.dispose();
    harvestYearController.dispose();
    areaController.dispose();
    productionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Yield Predictor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildDropdown('Country', countryOptions, selectedCountry,
                  (val) => setState(() => selectedCountry = val)),
              _buildDropdown('Admin Region', admin1Options, selectedAdmin,
                  (val) => setState(() => selectedAdmin = val)),
              _buildDropdown('Product', productOptions, selectedProduct,
                  (val) => setState(() => selectedProduct = val)),
              _buildDropdown('Season', seasonOptions, selectedSeason,
                  (val) => setState(() => selectedSeason = val)),
              _buildDropdown('System', systemOptions, selectedSystem,
                  (val) => setState(() => selectedSystem = val)),

              const SizedBox(height: 16),

              _buildYearField('Planting Year', plantingYearController),
              _buildDropdown('Planting Month', monthOptions, selectedPlantingMonth,
                  (val) => setState(() => selectedPlantingMonth = val)),
              _buildYearField('Harvest Year', harvestYearController),
              _buildDropdown('Harvest Month', monthOptions, selectedHarvestMonth,
                  (val) => setState(() => selectedHarvestMonth = val)),

              _buildNumberField('Area (ha)', areaController, min: 0.01),
              _buildNumberField('Production (kg)', productionController, min: 0),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isLoading ? null : predictYield,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Predict'),
              ),

              if (predictionResult != null) ...[
                const SizedBox(height: 20),
                Card(
                  color: predictionResult!.startsWith('✅')
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(predictionResult!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          final year = int.tryParse(value);
          if (year == null || year < 1900 || year > 2100) {
            return 'Enter a valid year (1900–2100)';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller,
      {double min = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          final numValue = double.tryParse(value);
          if (numValue == null || numValue < min) {
            return 'Enter value ≥ $min';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        value: value,
        onChanged: onChanged,
        items:
            items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }
}
