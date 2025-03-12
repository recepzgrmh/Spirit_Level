import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart';

class ScreenY extends StatefulWidget {
  const ScreenY({super.key});

  @override
  State<ScreenY> createState() => _ScreenYState();
}

class _ScreenYState extends State<ScreenY> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePositionY = 0.0;
  double sensitivityFactor = 40.0; // Y ekseni için hassasiyet
  double maxBubbleOffset = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Dikey moda sabitliyoruz
      DeviceOrientation.portraitDown,
    ]);

    accelerometerEvents.listen((event) {
      setState(() {
        xAccel = event.x;
        yAccel = event.y;
        zAccel = event.z;

        // Y ekseni için bubble pozisyonunu ayarla
        double newPositionY = (yAccel * sensitivityFactor).clamp(
          -maxBubbleOffset,
          maxBubbleOffset,
        );

        bubblePositionY = newPositionY;
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
      [],
    ); // Yönlendirme serbest bırakılıyor
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * 0.8;
    double bubbleSize = 60;
    maxBubbleOffset = (rectangleHeight - bubbleSize) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50, // Dikey modda ince uzun dikdörtgen
                  height: rectangleHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 184, 204, 0),
                        Color(0xFFF1F706),
                        Color.fromARGB(255, 184, 204, 0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 4),
                      bottom: BorderSide(color: Colors.black, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  top: ((rectangleHeight - bubbleSize) / 2) + bubblePositionY,
                  left: 10, // Ortalamak için hafif kaydırma
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: (rectangleHeight - 70) / 2,
                  child: Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2),
                        bottom: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
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
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    "Y: ${yAccel.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    "Z: ${zAccel.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
