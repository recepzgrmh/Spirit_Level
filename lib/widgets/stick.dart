import 'package:flutter/material.dart';
import '../styles/colors/app_colors.dart';

class Stick extends StatelessWidget {
  final double rectangleWidth;

  const Stick({super.key, required this.rectangleWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: rectangleWidth,
      height: 50,
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
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(3, 3)),
        ],
      ),
    );
  }
}
