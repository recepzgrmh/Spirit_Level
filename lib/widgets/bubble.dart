import 'package:flutter/material.dart';
import 'package:my_spirit/styles/colors/app_colors.dart';

class Bubble extends StatelessWidget {
  final double rectangleWidth;
  final double bubbleSize;
  final double bubblePositionX;
  final double? bubblePositionY;
  final double bottomOffset;

  const Bubble({
    super.key,
    required this.rectangleWidth,
    required this.bubbleSize,
    required this.bubblePositionX,
    this.bubblePositionY,
    this.bottomOffset = 18,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      left: ((rectangleWidth - bubbleSize) / 2) + bubblePositionX,
      top:
          bubblePositionY != null
              ? ((rectangleWidth - bubbleSize) / 2) + bubblePositionY!
              : null,
      bottom: bubblePositionY == null ? bottomOffset : null,
      child: Container(
        width: bubbleSize,
        height: bubbleSize,
        decoration: BoxDecoration(
          color: AppColors.bubbleColor,
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
