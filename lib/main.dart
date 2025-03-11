import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double xAccel = 0.0, yAccel = 0.0, zAccel = 0.0;
  double bubblePosition = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        xAccel = event.x;
        yAccel = event.y;
        zAccel = event.z;

        bubblePosition = (xAccel * 10).clamp(-100, 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 110 + bubblePosition,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
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
      ),
    );
  }
}
