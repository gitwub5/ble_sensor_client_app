import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/home/view/home_screen.dart';
import 'features/tag_management/view/tag_screen.dart';
import 'features/medicine_db/view/database_screen.dart';
import 'features/fridge_info/view/fridge_screen.dart';
import 'features/inventory_management/view/inventory_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "의약품 관리 시스템",
      theme: ThemeData(
        primaryColor: Colors.teal[600],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.teal[600],
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          // iconTheme: IconThemeData(color: Colors.teal[700]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/tag': (context) => TagScreen(),
        '/database': (context) => DatabaseScreen(),
        '/fridge': (context) => FridgeScreen(),
        '/inventory': (context) => InventoryScreen(),
      },
    );
  }
}
