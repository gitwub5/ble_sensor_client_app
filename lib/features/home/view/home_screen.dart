import 'package:flutter/material.dart';
import 'widgets/bluetooth_scan_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("의약품 관리 시스템")),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildGridButton(context, "Tag 관리", "/tag"),
                _buildGridButton(context, "의약품 등록", "/registration"),
                _buildGridButton(context, "의약품 품질관리", "/quality"),
                _buildGridButton(context, "의약품 DB", "/database"),
                _buildGridButton(context, "냉장고 정보", "/fridge"),
                _buildGridButton(context, "입출고 관리", "/inventory"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showBluetoothScanBottomSheet(context);
        },
        icon: Icon(Icons.bluetooth_searching, color: Colors.white), // ✅ 아이콘 변경
        label: Text("Scan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // ✅ 블루투스 색상으로 변경
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// 버튼 생성
  Widget _buildGridButton(BuildContext context, String title, String route) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(20),
      ),
      child: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }

  /// 블루투스 스캔 바텀시트
  void _showBluetoothScanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.purple[50],
      isScrollControlled: true, // ✅ 아래로 드래그하면 닫히도록 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return BluetoothScanBottomSheet(); // ✅ 빈 바텀시트 표시
      },
    );
  }
}
