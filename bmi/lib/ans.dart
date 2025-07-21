import 'package:flutter/material.dart';

class FinalAns extends StatelessWidget {
  final String result;
  const FinalAns({Key? key, required this.result}) : super(key: key);

  // ✅ Helper: Get BMI category
  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  // ✅ Helper: Get health message
  String getHealthMessage(String category) {
    switch (category) {
      case "Underweight":
        return "You are below a healthy weight. Consider a nutrition-rich diet.";
      case "Normal":
        return "Great! You have a healthy body weight.";
      case "Overweight":
        return "You're slightly over the healthy weight. Exercise can help.";
      case "Obese":
        return "You are in the obese range. Consider talking to a doctor.";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bmi = double.parse(result);
    final String formattedBMI = bmi.toStringAsFixed(2);
    final String category = getBMICategory(bmi);
    final String message = getHealthMessage(category);

    return Scaffold(
      appBar: AppBar(title: const Text("Your BMI Result")),
      backgroundColor: const Color(0xFF0A0E21),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1D1E33),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Your Result",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ✅ BMI Value
              Text(
                formattedBMI,
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // ✅ BMI Category
              Text(
                "Category: $category",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Health Message
              Text(
                message,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // ✅ Recalculate button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "RE-CALCULATE",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.5,
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
