// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_spirit/styles/colors/app_colors.dart';
import 'package:my_spirit/widgets/values.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ScreenXY extends StatefulWidget {
  const ScreenXY({super.key});

  @override
  State<ScreenXY> createState() => _ScreenXYState();
}

class _ScreenXYState extends State<ScreenXY> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePositionX = 0.0;
  double bubblePositionY = 0.0;
  double sensitivityFactor = 40.0;
  double maxBubbleOffset = 0.0;

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((event) {
      setState(() {
        xAccel = event.x;
        yAccel = event.y;
        zAccel = event.z;

        double newPositionX = (xAccel * sensitivityFactor).clamp(
          -maxBubbleOffset,
          maxBubbleOffset,
        );
        double newPositionY = (-yAccel * sensitivityFactor).clamp(
          -maxBubbleOffset,
          maxBubbleOffset,
        );
        bubblePositionX = newPositionX;
        bubblePositionY = newPositionY;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double circleDiameter = screenWidth * 0.8;
    double bubbleSize = 40;
    maxBubbleOffset = (circleDiameter - bubbleSize) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // daire
                Container(
                  width: circleDiameter,
                  height: circleDiameter,
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
                    border: Border.all(color: AppColors.borderColor, width: 3),
                    borderRadius: BorderRadius.circular(circleDiameter / 2),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.borderColor,
                        blurRadius: 12,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                // yatay ve dikey hedef çizgisi
                Positioned(
                  child: Container(
                    width: circleDiameter,
                    height: 1.5,
                    color: AppColors.borderColor,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 1.5,
                    height: circleDiameter,
                    color: AppColors.borderColor,
                  ),
                ),
                // Ortadaki hedef çember
                Positioned(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white38,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(68, 207, 10, 43),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                // Logo
                Positioned(
                  top: 60,
                  child: SvgPicture.asset(
                    'assets/images/izeltas-logo.svg',
                    semanticsLabel: 'İzeltas SVG Resim',
                    width: 15,
                    height: 15,
                  ),
                ),
                // Hareketli balon (X+Y)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  left: (circleDiameter - bubbleSize) / 2 + bubblePositionX,
                  top: (circleDiameter - bubbleSize) / 2 + bubblePositionY,
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: Color(0xFFB8EC42), // Yeşil balon
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Sensör değerlerinin gösterildiği kutucuk
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Values(xAccel: xAccel, yAccel: yAccel, zAccel: zAccel),
            ),
          ],
        ),
      ),
    );
  }
}
