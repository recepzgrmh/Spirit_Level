// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_spirit/styles/colors/app_colors.dart';
import 'package:my_spirit/widgets/stick.dart';
import 'package:my_spirit/widgets/values.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../widgets/bubble.dart';

class ScreenX extends StatefulWidget {
  const ScreenX({super.key});

  @override
  State<ScreenX> createState() => _ScreenXState();
}

class _ScreenXState extends State<ScreenX> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePosition = 0.0;
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

        // -yAccel kullanarak hesaplama
        double newPosition = (-yAccel * sensitivityFactor).clamp(
          -maxBubbleOffset,
          maxBubbleOffset,
        );
        bubblePosition = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * 0.8;
    double bubbleSize = 60;
    maxBubbleOffset = (rectangleWidth - bubbleSize) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Stick widget'ını gölgelendirmek için Material ile sarmalıyoruz.
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Stick(
                    rectangleWidth: rectangleWidth,
                    barHeight: 50,
                    topMargin: -25,
                  ),
                ),
                // Balon widget'ı
                Bubble(
                  rectangleWidth: rectangleWidth,
                  bubbleSize: bubbleSize,
                  bubblePositionX: bubblePosition,
                ),
                // Ortadaki ince dikdörtgen (hedef çizgisi)
                Positioned(
                  left: (rectangleWidth - 70) / 2,
                  child: Container(
                    width: 70,
                    height: 50,
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
