// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_spirit/styles/colors/app_colors.dart';
import 'package:my_spirit/widgets/values.dart';
import 'package:my_spirit/widgets/bubble.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ScreenXY extends StatefulWidget {
  const ScreenXY({super.key});

  @override
  State<ScreenXY> createState() => _ScreenXYState();
}

class _ScreenXYState extends State<ScreenXY> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  final double sensitivityFactor = 40.0;

  @override
  void initState() {
    super.initState();
    // Sensör verilerini dinle
    accelerometerEvents.listen((event) {
      setState(() {
        xAccel = event.x;
        yAccel = event.y;
        zAccel = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutunu ve hesaplamaları burada yapıyoruz
    double screenWidth = MediaQuery.of(context).size.width;
    double circleDiameter = screenWidth * 0.8;
    double bubbleSize = 40.0;
    double maxBubbleOffset = (circleDiameter - bubbleSize) / 2;

    // Güncel balon pozisyonlarını build aşamasında hesaplıyoruz:
    double calculatedBubblePositionX = (xAccel * sensitivityFactor).clamp(
      -maxBubbleOffset,
      maxBubbleOffset,
    );
    double calculatedBubblePositionY = (-yAccel * sensitivityFactor).clamp(
      -maxBubbleOffset,
      maxBubbleOffset,
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Daire arka plan
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
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(circleDiameter / 2),
                    boxShadow: const [
                      BoxShadow(color: AppColors.borderColor, blurRadius: 7),
                    ],
                  ),
                ),
                // Yatay hedef çizgisi
                Positioned(
                  child: Container(
                    width: circleDiameter,
                    height: 1.5,
                    color: AppColors.borderColor,
                  ),
                ),
                // Dikey hedef çizgisi
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
                  top: 10,
                  child: Image.asset(
                    'assets/images/ilogo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                // Balon
                Bubble(
                  rectangleWidth: circleDiameter,
                  bubbleSize: bubbleSize,
                  bubblePositionX: calculatedBubblePositionX,
                  bubblePositionY: calculatedBubblePositionY,
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Sensör değerlerini gösteren kutucuk
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Values(xAccel: xAccel, yAccel: yAccel, zAccel: zAccel),
            ),
          ],
        ),
      ),
    );
  }
}
