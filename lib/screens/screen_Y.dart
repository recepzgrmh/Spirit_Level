// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ScreenY extends StatefulWidget {
  const ScreenY({super.key});

  @override
  State<ScreenY> createState() => _ScreenYState();
}

class _ScreenYState extends State<ScreenY> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePositionX = 0.0;
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
                Container(
                  width: rectangleWidth,
                  height: barHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 184, 204, 0),
                        const Color(0xFFF1F706),
                        const Color.fromARGB(255, 184, 204, 0),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: const Border(
                      left: BorderSide(color: Colors.black, width: 4),
                      right: BorderSide(color: Colors.black, width: 4),
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
                // Ortada hedef göstergesi (çubuk üzerinde)
                Positioned(
                  left: (rectangleWidth - 70) / 2,
                  child: Container(
                    width: 70,
                    height: barHeight,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 2),
                        right: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                // Balon, xAccel üzerinden yatay olarak hareket ediyor
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  left: ((rectangleWidth - bubbleSize) / 2) + bubblePositionX,
                  top: (barHeight - bubbleSize) / 2,
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Sensör değerlerini gösteren kutucuk
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
