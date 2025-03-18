import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_spirit/screens/screen_X.dart';
import 'package:my_spirit/screens/screen_XY.dart';
import 'package:my_spirit/screens/screen_Y.dart';
import '../styles/colors/app_colors.dart';
import '../widgets/navButtons.dart'; // NavButton widget'ını import ediyoruz

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sayfa sıralaması: 0: X Ekseni, 1: X+Y, 2: Y Ekseni
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _updateOrientation();
  }

  void _updateOrientation() {
    if (currentPageIndex == 0) {
      // X Ekseni sayfası için landscape mod
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // X+Y ve Y Ekseni sayfaları için portrait mod
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const ScreenX(),
      const ScreenXY(),
      const ScreenY(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Su Terazisi Uygulaması",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
      ),
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            NavButton(
              text: "X Ekseni",
              index: 0,
              currentPageIndex: currentPageIndex,
              onPressed: () {
                setState(() {
                  currentPageIndex = 0;
                  _updateOrientation();
                });
              },
            ),
            const SizedBox(width: 25),
            NavButton(
              text: "X + Y",
              index: 1,
              currentPageIndex: currentPageIndex,
              onPressed: () {
                setState(() {
                  currentPageIndex = 1;
                  _updateOrientation();
                });
              },
            ),
            const SizedBox(width: 25),
            NavButton(
              text: "Y Ekseni",
              index: 2,
              currentPageIndex: currentPageIndex,
              onPressed: () {
                setState(() {
                  currentPageIndex = 2;
                  _updateOrientation();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
