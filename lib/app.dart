import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/home/view/home_screen.dart';
import 'features/tag_management/tag/view/tag_screen.dart';
import 'features/medicine_management/view/medicine_screen.dart';
import 'features/fridge_management/view/fridge_screen.dart';
import 'test/ble/view/ble_scan_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "의약품 관리 시스템",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/tag': (context) => TagScreen(),
        '/medicine': (context) => MedicineScreen(),
        '/fridge': (context) => FridgeScreen(),
        '/test': (context) => BleTestScanScreen(),
      },
    );
  }
}
