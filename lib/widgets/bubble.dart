import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final double rectangleWidth;
  final double bubbleSize;
  final double bubblePosition; // Hesaplanmış konum

  const Bubble({
    super.key,
    required this.rectangleWidth,
    required this.bubbleSize,
    required this.bubblePosition,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      left: ((rectangleWidth - bubbleSize) / 2) + bubblePosition,
      bottom: 18,
      child: Container(
        width: bubbleSize,
        height: bubbleSize,
        decoration: BoxDecoration(
          color: const Color(0xFFB8EC42),
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
    );
  }
}
