/*
  Ble에서 온 데이터 반환
*/
import 'dart:convert';

/// 📌 BLE 데이터 수신 및 처리 유틸리티
class BleReceiver {
  List<Map<String, dynamic>> _sensorData = []; // 수신된 센서 데이터 저장
  int _totalBatches = 0; // 총 데이터 배치 개수
  int _receivedBatches = 0; // 수신된 데이터 배치 개수

  /// 📌 **수신된 BLE 데이터를 처리**
  void handleReceivedData(String rawData) {
    try {
      final Map<String, dynamic> jsonData = json.decode(rawData); // JSON 변환

      // ✅ "update" 명령 응답 처리
      if (jsonData.containsKey("command") && jsonData["command"] == "update") {
        print("📩 Update 명령 응답 수신 완료");
        return;
      }

      // ✅ 배치 데이터 수신 처리
      if (jsonData.containsKey("batch") && jsonData.containsKey("data")) {
        _processBatchData(jsonData);
        return;
      }

      // ✅ 상태 업데이트 메시지 처리
      if (jsonData.containsKey("status") && jsonData["status"] == "success") {
        print("✅ 데이터 업데이트 완료: ${jsonData["message"]}");
        _clearReceivedData(); // 기존 데이터 초기화
        return;
      }

      print("⚠️ 알 수 없는 데이터 수신: $rawData");
    } catch (e) {
      print("❌ 데이터 처리 오류: $e");
    }
  }

  /// 📌 **배치 데이터 처리**
  void _processBatchData(Map<String, dynamic> jsonData) {
    final int batchIndex = jsonData["batch"]["index"];
    final int totalBatches = jsonData["batch"]["total"];
    final List<String> batchData = List<String>.from(jsonData["data"]);

    if (_totalBatches == 0) {
      _totalBatches = totalBatches; // 총 배치 개수 저장
    }

    _sensorData.addAll(batchData.map((line) => _parseCsvLine(line))); // 데이터 저장
    _receivedBatches++;

    print("📥 데이터 배치 수신 완료: $batchIndex / $totalBatches");

    // 모든 배치를 수신하면 최종 데이터 출력
    if (_receivedBatches >= _totalBatches) {
      print("✅ 모든 데이터 수신 완료!");
      print("📊 수신된 센서 데이터:");
      _sensorData.forEach((row) => print(row));

      // ✅ 필요한 후속 처리를 추가할 수 있음 (예: DB 저장, UI 갱신)
    }
  }

  /// 📌 **CSV 라인 파싱**
  Map<String, dynamic> _parseCsvLine(String csvLine) {
    final List<String> parts = csvLine.split(",");
    if (parts.length < 5) {
      throw FormatException("잘못된 CSV 형식: $csvLine");
    }

    return {
      "Number": int.parse(parts[0]),
      "Time": parts[1],
      "Temperature": double.parse(parts[2]),
      "Humidity": double.parse(parts[3]),
      "CPU Temperature": double.parse(parts[4]),
    };
  }

  /// 📌 **수신 데이터 초기화**
  void _clearReceivedData() {
    _sensorData.clear();
    _totalBatches = 0;
    _receivedBatches = 0;
    print("🗑️ 수신된 데이터 초기화 완료");
  }
}
