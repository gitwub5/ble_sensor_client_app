import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                HomeViewModel()), // ✅ 앱 전체에서 HomeViewModel 사용 가능하도록 등록
      ],
      child: App(),
    ),
  );
}
