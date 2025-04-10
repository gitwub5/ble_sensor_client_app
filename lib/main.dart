import 'app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:bluetooth_app/features/tag_management/tag/viewmodel/tag_viewmodel.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/viewmodel/tag_data_viewmodel.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/repository/tag_data_repository.dart';
import 'package:bluetooth_app/features/tag_management/tag/repository/tag_repository.dart';
import 'package:bluetooth_app/test/ble/viewmodel/test_viewmodel.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 초기화
  await initializeDateFormatting('ko', null);

  //  BluetoothManager 싱글턴 인스턴스 생성
  final bluetoothManager = BluetoothManager();
  bluetoothManager.setLoggingEnabled(true);

  final database = AppDatabase(); // Drift 싱글턴 인스턴스
  final tagRepository = TagRepository(database); // Repository에 DB 주입
  final tagDataRepository = TagDataRepository(database);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => bluetoothManager), // BluetoothManager 주입
        Provider(create: (_) => database), // Database 주입
        Provider(create: (_) => tagRepository), // Repository 주입
        Provider(create: (_) => tagDataRepository),
        ChangeNotifierProvider(
            create: (context) =>
                HomeViewModel(context.read<BluetoothManager>())),
        ChangeNotifierProvider(
            create: (context) => TagViewModel(
                  context.read<BluetoothManager>(),
                  context.read<TagRepository>(),
                  context.read<TagDataRepository>(),
                  context.read<HomeViewModel>(),
                )),
        ChangeNotifierProvider(
          create: (context) =>
              TagDataViewModel(context.read<TagDataRepository>()),
          // TagDataViewModel 주입
        ),
        ChangeNotifierProvider(
            create: (context) =>
                BleTestViewModel(context.read<BluetoothManager>())),
      ],
      child: App(),
    ),
  );
}
