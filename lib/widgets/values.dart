import 'package:flutter/material.dart';
import '../styles/colors/app_colors.dart';

class Values extends StatelessWidget {
  final double xAccel;
  final double yAccel;
  final double zAccel;

  const Values({
    super.key,
    required this.xAccel,
    required this.yAccel,
    required this.zAccel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "X: ${xAccel.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            "Y: ${yAccel.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            "Z: ${zAccel.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
