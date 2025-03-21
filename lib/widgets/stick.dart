import 'package:flutter/material.dart';
import '../styles/colors/app_colors.dart';

class Stick extends StatelessWidget {
  final double rectangleWidth;
  final double barHeight;
  final double topMargin;

  const Stick({
    super.key,
    required this.rectangleWidth,
    required this.barHeight,
    required this.topMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Material widget ile elevation ekleyerek gölge oluşturuyoruz
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: rectangleWidth + 5,
            height: barHeight,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFDCDCDC),
                  Color(0xFFFAFAFA),
                  Color(0xFFDCDCDC),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: const Border(
                left: BorderSide(color: AppColors.borderColor, width: 4),
                right: BorderSide(color: AppColors.borderColor, width: 4),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // Merkezdeki iki çubuk
        Positioned(
          left: (rectangleWidth - 70) / 2,
          child: Container(
            width: 70,
            height: barHeight,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.borderColor, width: 2),
                right: BorderSide(color: AppColors.borderColor, width: 2),
              ),
            ),
          ),
        ),
        // Logo
        Positioned(
          left: 20,
          top: topMargin,
          child: Image.asset(
            'assets/images/ilogo.png',
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
