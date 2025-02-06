import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';
import 'features/tag_management/viewmodel/tag_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => TagViewModel()),
      ],
      child: App(),
    ),
  );
}
