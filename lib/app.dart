import 'package:flutter/material.dart';
import 'features/home/view/home_screen.dart';
import 'features/tag_management/view/tag_screen.dart';
import 'features/medicine_registration/view/registration_screen.dart';
import 'features/quality_management/view/quality_screen.dart';
import 'features/medicine_db/view/database_screen.dart';
import 'features/fridge_info/view/fridge_screen.dart';
import 'features/inventory_management/view/inventory_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "의약품 관리 시스템",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/tag': (context) => TagScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/quality': (context) => QualityScreen(),
        '/database': (context) => DatabaseScreen(),
        '/fridge': (context) => FridgeScreen(),
        '/inventory': (context) => InventoryScreen(),
      },
    );
  }
}
