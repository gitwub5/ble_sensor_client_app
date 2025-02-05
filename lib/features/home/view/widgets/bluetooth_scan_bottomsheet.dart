import 'package:flutter/material.dart';

class BluetoothScanBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ 좌우로 꽉 차게 설정
      height: MediaQuery.of(context).size.height * 0.5, // ✅ 화면 높이의 50% 사용
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bluetooth_searching, size: 50, color: Colors.blue),
          SizedBox(height: 20),
          Text("블루투스 검색 준비 완료", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text(
            "아래 버튼을 눌러 블루투스 검색을 시작하세요.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // 추후 블루투스 검색 기능 추가
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text("검색 시작"),
          ),
        ],
      ),
    );
  }
}
