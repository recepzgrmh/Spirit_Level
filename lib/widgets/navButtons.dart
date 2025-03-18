import 'package:flutter/material.dart';
import '../styles/colors/app_colors.dart';

class NavButton extends StatelessWidget {
  final String text;
  final int index;
  final int currentPageIndex;
  final VoidCallback onPressed;

  const NavButton({
    super.key,
    required this.text,
    required this.index,
    required this.currentPageIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Yuvarlatılmış köşeler
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                currentPageIndex == index
                    ? AppColors.primaryColor.withOpacity(0.8)
                    : AppColors.buttonColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Color.fromARGB(61, 42, 48, 119),
                width: 1.5,
              ),
            ),
            elevation:
                0, // BackdropFilter ile kullanıldığı için elevation kapalı
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  currentPageIndex == index
                      ? Colors.black
                      : AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
