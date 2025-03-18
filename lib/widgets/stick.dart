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
        Container(
          width: rectangleWidth,
          height: barHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFDCDCDC), Color(0xFFFAFAFA), Color(0xFFDCDCDC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: const Border(
              left: BorderSide(color: AppColors.borderColor, width: 4),
              right: BorderSide(color: AppColors.borderColor, width: 4),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(3, 3),
              ),
            ],
          ),
        ),
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
            'assets/images/ilogo.png', // SVG yerine dönüştürülmüş resim dosyası
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
