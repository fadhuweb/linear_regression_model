import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dropdown_options.dart';

class PredictScreen extends StatefulWidget {
  const PredictScreen({Key? key}) : super(key: key);

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  final _formKey = GlobalKey<FormState>();
  final plantingYearController = TextEditingController();
  final harvestYearController = TextEditingController();
  final areaController = TextEditingController();

  final countryController = TextEditingController(text: countryOptions.first);
  final adminController = TextEditingController(text: admin1Options.first);
  final productController = TextEditingController(text: productOptions.first);
  final seasonController = TextEditingController(text: seasonOptions.first);
  final systemController = TextEditingController(text: systemOptions.first);
  final plantingMonthController = TextEditingController(text: monthOptions.first);
  final harvestMonthController = TextEditingController(text: monthOptions[4]);

  bool isLoading = false;
  bool useTons = false;
  String? predictionResult;
  bool isErrorResult = false;

  Future<void> predictYield() async {
    if (!_formKey.currentState!.validate()) return;

    final plantingYear = int.tryParse(plantingYearController.text);
    final harvestYear = int.tryParse(harvestYearController.text);
    final plantingMonth = int.parse(plantingMonthController.text.split(' - ')[0]);
    final harvestMonth = int.parse(harvestMonthController.text.split(' - ')[0]);

    if (harvestYear! < plantingYear! || (harvestYear == plantingYear && harvestMonth <= plantingMonth)) {
      setState(() {
        predictionResult = "❌ Error: Harvest date must be after planting date.";
        isErrorResult = true;
      });
      return;
    }

    setState(() {
      isLoading = true;
      predictionResult = null;
    });

    final url = Uri.parse('https://linear-regression-model-4-49xg.onrender.com/predict');
    final body = {
      'country': countryController.text,
      'admin_1': adminController.text,
      'product': productController.text,
      'season_name': seasonController.text,
      'planting_year': plantingYear,
      'planting_month': plantingMonth,
      'harvest_year': harvestYear,
      'harvest_month': harvestMonth,
      'crop_production_system': systemController.text,
      'area': double.parse(areaController.text),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        double prediction = result['predicted_production'];

        if (useTons) prediction /= 1000;

        final formatted = NumberFormat('#,##0.00').format(prediction);
        final unit = useTons ? 'tons' : 'kg';

        setState(() {
          predictionResult = "✅ Predicted Production: $formatted $unit";
          isErrorResult = false;
        });
      } else {
        final err = jsonDecode(response.body);
        final detail = err['detail'];
        final message = detail is List
            ? detail.map((e) => e['msg']).join('\n')
            : detail.toString();
        setState(() {
          predictionResult = "❌ Error: $message";
          isErrorResult = true;
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "❌ Network error: $e";
        isErrorResult = true;
      });
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    plantingYearController.dispose();
    harvestYearController.dispose();
    areaController.dispose();
    countryController.dispose();
    adminController.dispose();
    productController.dispose();
    seasonController.dispose();
    systemController.dispose();
    plantingMonthController.dispose();
    harvestMonthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('🌾 Crop Production Predictor'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAnimatedSection('🧭 Location Info', [
                  _buildAutocompleteField('Country', countryOptions, countryController),
                  _buildAutocompleteField('Admin Region', admin1Options, adminController),
                  _buildAutocompleteField('Product', productOptions, productController),
                ]),
                _buildAnimatedSection('📅 Season Details', [
                  _buildAutocompleteField('Season', seasonOptions, seasonController),
                  _buildAutocompleteField('System', systemOptions, systemController),
                  _buildYearField('Planting Year', plantingYearController),
                  _buildAutocompleteField('Planting Month', monthOptions, plantingMonthController),
                  _buildYearField('Harvest Year', harvestYearController),
                  _buildAutocompleteField('Harvest Month', monthOptions, harvestMonthController),
                ]),
                _buildAnimatedSection('📐 Area Info', [
                  _buildNumberField('Area (ha)', areaController, min: 0.01),
                ]),
                _buildAnimatedSection('⚙️ Output Unit', [
                  _buildUnitSwitch(),
                ]),
                if (predictionResult != null)
                  _buildPredictionCard(predictionResult!, isErrorResult),
                const SizedBox(height: 20),
                _buildPredictButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, List<Widget> children) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + Random().nextInt(300)),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, (1 - opacity) * 20),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPredictionCard(String result, bool isError) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Card(
            color: isError ? Colors.red[50] : Colors.green[50],
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: isError ? Colors.red : Colors.green[700],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      result,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: isError ? Colors.red[900] : Colors.green[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          final year = int.tryParse(value);
          if (year == null || year < 1900 || year > 2100) return 'Enter a valid year (1900–2100)';
          return null;
        },
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller, {double min = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          final numValue = double.tryParse(value);
          if (numValue == null || numValue < min) return 'Enter value ≥ $min';
          return null;
        },
      ),
    );
  }

  Widget _buildAutocompleteField(String label, List<String> options, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Autocomplete<String>(
        initialValue: TextEditingValue(text: controller.text),
        optionsBuilder: (TextEditingValue textEditingValue) {
          return options.where((option) =>
              option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (String selection) => controller.text = selection,
        fieldViewBuilder: (context, textFieldController, focusNode, onFieldSubmitted) {
          return TextFormField(
            controller: textFieldController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              if (!options.contains(value)) return 'Invalid selection';
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildUnitSwitch() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade100,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("kg", style: TextStyle(fontWeight: FontWeight.w600)),
            Switch(
              activeColor: Colors.green,
              value: useTons,
              onChanged: (val) => setState(() => useTons = val),
            ),
            const Text("tons", style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.agriculture_rounded),
        label: const Text('Predict'),
        onPressed: isLoading ? null : predictYield,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
