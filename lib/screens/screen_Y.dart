// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_spirit/widgets/stick.dart';
import '../widgets/values.dart';
import 'package:sensors_plus/sensors_plus.dart';
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
                // Gölge eklemek için Stick widget'ını Material ile sarmalıyoruz.
                Material(
                  color: const Color.fromARGB(
                    255,
                    0,
                    0,
                    0,
                  ), // Açık ve belirgin bir arka plan rengi verin.
                  elevation: 80, // Gölgenin derinliği
                  borderRadius: BorderRadius.circular(8),
                  child: Stick(
                    rectangleWidth: rectangleWidth,
                    barHeight: barHeight,
                    topMargin: -23,
                  ),
                ),

                // Balon widget'ı
                Bubble(
                  rectangleWidth: rectangleWidth,
                  bubbleSize: bubbleSize,
                  bubblePositionX: bubblePositionX,
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
