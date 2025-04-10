import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class MedicineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "의약품 관리"),
      body: Center(child: Text("의약품 DB 페이지")),
    );
  }
}
