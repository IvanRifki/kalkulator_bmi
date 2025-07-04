import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator_bmi/screens/calculator_screen.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Color(0xFF8D8E98),
          thumbColor: Color(0xFFEB1555),
          overlayColor: Color(0x29EB1555),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFEB1555),
            textStyle:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const BMICalculatorScreen(),
    );
  }
}
