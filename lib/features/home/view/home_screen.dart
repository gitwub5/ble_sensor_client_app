import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("의약품 관리 시스템")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: homeViewModel.startScan,
            child: Text("블루투스 검색 시작"),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: homeViewModel.scanResults.length,
              itemBuilder: (context, index) {
                final device = homeViewModel.scanResults[index].device;
                return ListTile(
                  title: Text(device.platformName.isNotEmpty
                      ? device.platformName
                      : "Unknown Device"),
                  subtitle: Text(device.remoteId.toString()),
                  trailing: ElevatedButton(
                    onPressed: () => homeViewModel.connectToDevice(device),
                    child: Text("연결"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
