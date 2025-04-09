import 'package:bluetooth_app/core/database/database.dart';
import 'package:drift/drift.dart';

Future<List<TagDataCompanion>> bleReceiver(
    int tagId, Map<String, dynamic> data) async {
  try {
    if (data['data'] == null || !(data['data'] is List)) {
      print("❌ 데이터 파싱 오류: 잘못된 형식");
      return [];
    }

    final List<List<dynamic>> dataList = List<List<dynamic>>.from(data['data']);
    final List<TagDataCompanion> entries = [];

    for (var item in dataList) {
      if (item.length != 3) continue; // 형식이 맞지 않는 데이터는 무시

      final DateTime? time = DateTime.tryParse(item[0]);
      final double? temperature = double.tryParse(item[1].toString());
      final double? humidity = double.tryParse(item[2].toString());

      if (time != null && temperature != null && humidity != null) {
        entries.add(TagDataCompanion(
          tagId: Value(tagId),
          time: Value(time),
          temperature: Value(temperature),
          humidity: Value(humidity),
        ));
      }
    }

    print("✅ BLE 데이터 파싱 성공, ${entries.length}개 항목 파싱 완료");
    return entries;
  } catch (e) {
    print("❌ 데이터 파싱 오류: $e");
    return [];
  }
}
