// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
                // Ana daire
                Container(
                  width: circleDiameter,
                  height: circleDiameter,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [
                        Color.fromARGB(255, 219, 241, 19),
                        Color(0xFFF1F706),
                      ],
                      center: Alignment.center,
                      radius: 1.2,
                    ),
                    border: Border.all(color: Colors.black87, width: 3),
                    borderRadius: BorderRadius.circular(circleDiameter / 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 12,
                        offset: Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.white30,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // Referans çizgileri (yatay ve dikey)
                Positioned(
                  child: Container(
                    width: circleDiameter,
                    height: 1.5,
                    color: const Color.fromARGB(100, 0, 0, 0),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 1.5,
                    height: circleDiameter,
                    color: const Color.fromARGB(100, 0, 0, 0),
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
                        color: const Color.fromARGB(200, 255, 255, 255),
                        width: 4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white38,
                          blurRadius: 14,
                          spreadRadius: 3,
                        ),
                        BoxShadow(color: Colors.black26, blurRadius: 8),
                      ],
                    ),
                  ),
                ),
                // Hareketli balon
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  left: (circleDiameter - bubbleSize) / 2 + bubblePositionX,
                  top: (circleDiameter - bubbleSize) / 2 + bubblePositionY,
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade300,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                        BoxShadow(
                          color: Colors.white38,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Sensör değerlerinin gösterildiği kutucuk
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 3),
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
            ),
          ],
        ),
      ),
    );
  }
}
