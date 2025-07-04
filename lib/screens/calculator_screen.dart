import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:kalkulator_bmi/utils/app_constants.dart';
import 'package:kalkulator_bmi/widgets/custom_widgets.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  Gender? _selectedGender;
  double _height = 160;
  int _weight = 50;
  int _age = 25;

  void _calculateAndShowBMI() {
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Silakan pilih jenis kelamin terlebih dahulu.')),
      );
      return;
    }

    double heightInMeters = _height / 100;
    double bmi = _weight / pow(heightInMeters, 2);

    String category;
    String interpretation;
    Color categoryColor;

    if (bmi < 18.5) {
      category = 'Berat Badan Kurang';
      interpretation =
          'Anda memiliki berat badan lebih rendah dari normal. Coba perbanyak asupan kalori sehat.';
      categoryColor = Colors.blue;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      category = 'Normal';
      interpretation = 'Berat badan Anda ideal. Pertahankan!';
      categoryColor = Colors.green;
    } else if (bmi >= 25 && bmi <= 29.9) {
      category = 'Berat Badan Berlebih';
      interpretation =
          'Anda memiliki berat badan berlebih. Pertimbangkan untuk berolahraga dan mengatur pola makan.';
      categoryColor = Colors.orange;
    } else {
      category = 'Obesitas';
      interpretation =
          'Anda berada dalam kategori obesitas. Sangat disarankan untuk berkonsultasi dengan dokter.';
      categoryColor = Colors.red;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1E33),
        title: const Text('Hasil BMI Anda',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 10,
                      maximum: 40,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Colors.grey,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: bmi,
                          enableAnimation: true,
                          animationType: AnimationType.ease,
                          needleStartWidth: 1,
                          needleEndWidth: 5,
                          needleColor: const Color(0xFFEB1555),
                          knobStyle: const KnobStyle(
                            knobRadius: 0.08,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Color(0xFFEB1555),
                          ),
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            bmi.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          angle: 90,
                          positionFactor: 1.2,
                        )
                      ],
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 10,
                            endValue: 18.4,
                            color: Colors.blue,
                            startWidth: 0.2,
                            endWidth: 0.2,
                            sizeUnit: GaugeSizeUnit.factor),
                        GaugeRange(
                            startValue: 18.5,
                            endValue: 24.9,
                            color: Colors.green,
                            startWidth: 0.2,
                            endWidth: 0.2,
                            sizeUnit: GaugeSizeUnit.factor),
                        GaugeRange(
                            startValue: 25,
                            endValue: 29.9,
                            color: Colors.orange,
                            startWidth: 0.2,
                            endWidth: 0.2,
                            sizeUnit: GaugeSizeUnit.factor),
                        GaugeRange(
                            startValue: 30,
                            endValue: 40,
                            color: Colors.red,
                            startWidth: 0.2,
                            endWidth: 0.2,
                            sizeUnit: GaugeSizeUnit.factor),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                category,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                interpretation,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('HITUNG ULANG'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI KALKULATOR'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ReusableCard(
                          onTap: () =>
                              setState(() => _selectedGender = Gender.male),
                          color: _selectedGender == Gender.male
                              ? const Color(0xFFEB1555)
                              : const Color(0xFF111328),
                          child: const IconContent(
                              icon: Icons.male, label: 'PRIA'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ReusableCard(
                          onTap: () =>
                              setState(() => _selectedGender = Gender.female),
                          color: _selectedGender == Gender.female
                              ? const Color(0xFFEB1555)
                              : const Color(0xFF111328),
                          child: const IconContent(
                              icon: Icons.female, label: 'WANITA'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ReusableCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('TINGGI BADAN', style: teksLabel),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(_height.round().toString(),
                                style: kNumberTextStyle),
                            const Text('cm', style: teksLabel),
                          ],
                        ),
                        Slider(
                          value: _height,
                          min: 120,
                          max: 220,
                          onChanged: (double value) {
                            setState(() => _height = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ReusableCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('BERAT BADAN', style: teksLabel),
                              Text(_weight.toString(), style: kNumberTextStyle),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundIconButton(
                                      icon: Icons.remove,
                                      onPressed: () =>
                                          setState(() => _weight--)),
                                  const SizedBox(width: 10),
                                  RoundIconButton(
                                      icon: Icons.add,
                                      onPressed: () =>
                                          setState(() => _weight++)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ReusableCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('UMUR', style: teksLabel),
                              Text(_age.toString(), style: kNumberTextStyle),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundIconButton(
                                      icon: Icons.remove,
                                      onPressed: () => setState(() => _age--)),
                                  const SizedBox(width: 10),
                                  RoundIconButton(
                                      icon: Icons.add,
                                      onPressed: () => setState(() => _age++)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _calculateAndShowBMI,
                  child: const Text(
                    'HITUNG BMI ANDA',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
