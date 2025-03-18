// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_spirit/styles/colors/app_colors.dart';
import 'package:my_spirit/widgets/stick.dart';
import '../widgets/values.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bubble.dart';

class ScreenY extends StatefulWidget {
  const ScreenY({super.key});

  @override
  State<ScreenY> createState() => _ScreenYState();
}

class _ScreenYState extends State<ScreenY> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePositionX = 0.0;
  final double sensitivityFactor = 40.0;
  double maxBubbleOffset = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        xAccel = event.x;
        yAccel = event.y;
        zAccel = event.z;

        // X ekseninde hareket için hesaplama:
        double newPositionX = (xAccel * sensitivityFactor).clamp(
          -maxBubbleOffset,
          maxBubbleOffset,
        );
        bubblePositionX = newPositionX;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * 0.8;
    double barHeight = 50.0;
    double bubbleSize = 40.0;
    maxBubbleOffset = (rectangleWidth - bubbleSize) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yatay çubuk ve hareketli balon
            Stack(
              alignment: Alignment.center,
              children: [
                // Gümüş rengi çubuk
                Stick(rectangleWidth: rectangleWidth),
                // Ortada hedef göstergesi (çubuk üzerinde)
                Positioned(
                  left: (rectangleWidth - 70) / 2,
                  child: Container(
                    width: 70,
                    height: barHeight,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: AppColors.borderColor,
                          width: 2,
                        ),
                        right: BorderSide(
                          color: AppColors.borderColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                // Logo
                Positioned(
                  left: 30,
                  child: SvgPicture.asset(
                    'assets/images/izeltas-logo.svg',
                    semanticsLabel: 'İzeltas SVG Resim',
                    width: 10,
                    height: 10,
                  ),
                ),
                // Balon widget'ı
                Bubble(
                  rectangleWidth: rectangleWidth,
                  bubbleSize: bubbleSize,
                  bubblePosition: bubblePositionX,
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
