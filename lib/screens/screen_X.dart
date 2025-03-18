// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_spirit/widgets/values.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ScreenX extends StatefulWidget {
  const ScreenX({super.key});

  @override
  State<ScreenX> createState() => _ScreenXState();
}

class _ScreenXState extends State<ScreenX> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePosition = 0.0;
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
                //  çubuk
                Container(
                  width: rectangleWidth,
                  height: 50,
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
                    // Siyah kenarlar
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
                // Balon
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  left: ((rectangleWidth - bubbleSize) / 2) + bubblePosition,
                  bottom: 18,
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: Color(0xFFB8EC42),
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
                // Ortadaki ince dikdörtgen (hedef çizgisi)
                Positioned(
                  left: (rectangleWidth - 70) / 2,
                  child: Container(
                    width: 70,
                    height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 2),
                        right: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Sensör değerlerini gösteren kutucuk
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
