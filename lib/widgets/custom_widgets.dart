import 'package:flutter/material.dart';
import 'package:kalkulator_bmi/utils/app_constants.dart';

// Cardnya
class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget? child;
  final VoidCallback? onTap;

  const ReusableCard(
      {super.key,
      this.color = const Color(0xFF1D1E33),
      this.child,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}

// Card gender
class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconContent({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80.0),
        const SizedBox(height: 15.0),
        Text(label, style: teksLabel),
      ],
    );
  }
}

// Tombol +-
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}
