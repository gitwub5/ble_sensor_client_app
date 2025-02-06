import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              padding: EdgeInsets.all(30),
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              children: [
                _buildGridButton(context, "Tag 관리", "/tag"),
                _buildGridButton(context, "냉장고 관리", "/fridge"),
                _buildGridButton(context, "의약품 DB", "/database"),
                _buildGridButton(context, "의약품 입출고 관리", "/inventory"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showBluetoothScanBottomSheet(context);
        },
        icon: Icon(Icons.bluetooth_searching, color: Colors.white),
        label: Text("Scan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// 버튼 생성
  Widget _buildGridButton(BuildContext context, String title, String route) {
    return MouseRegion(
      onEnter: (event) => _onHover(context, true),
      onExit: (event) => _onHover(context, false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.teal[600],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, route),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(16),
          ),
          child:
              Text(title, style: TextStyle(fontSize: 15, color: Colors.white)),
        ),
      ),
    );
  }

  /// Hover 효과 (마우스를 올리면 색상이 변경됨)
  void _onHover(BuildContext context, bool isHovered) {
    if (isHovered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("마우스를 올리면 색상이 변경됩니다!"),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  /// 블루투스 스캔 바텀시트
  void _showBluetoothScanBottomSheet(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.purple[50],
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return BluetoothScanBottomSheet();
      },
    ).whenComplete(() {
      homeViewModel.scanResults.clear();
      homeViewModel.notifyListeners(); // UI 업데이트 반영
    });
  }
}
