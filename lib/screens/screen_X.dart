// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: rectangleWidth,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stick(
                    rectangleWidth: rectangleWidth,
                    barHeight: 50,
                    topMargin: -25,
                  ),
                ),
                // Balon widget'ı
                Bubble(
                  rectangleWidth: rectangleWidth,
                  bubbleSize: bubbleSize - 17,
                  bubblePositionX: bubblePosition,
                ),
              ],
            ),
            // Sensör değerlerini gösteren kutucuk
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Values(xAccel: xAccel, yAccel: yAccel, zAccel: zAccel),
            ),
          ],
        ),
      ),
    );
  }
}
