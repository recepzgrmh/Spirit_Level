import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_spirit/screens/screen_X.dart';
import 'package:my_spirit/screens/screen_XY.dart';
import 'package:my_spirit/screens/screen_Y.dart';

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
        title: const Text("Su Terazisi Uygulaması"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton("X Ekseni", 0),
            _buildNavButton("X + Y", 1),
            _buildNavButton("Y Ekseni", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int index) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            currentPageIndex = index;
            _updateOrientation();
          });
        },
        style: ElevatedButton.styleFrom(
          // Aktif sayfada metalik ton, pasif sayfada gri ton
          backgroundColor:
              currentPageIndex == index
                  ? const Color(0xFFDCDCDC)
                  : Colors.grey[500],
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // Aktif sayfada siyah yazı, pasif sayfada siyaha yakın gri
            color: currentPageIndex == index ? Colors.black : Colors.black87,
          ),
        ),
      ),
    );
  }
}
