import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FridgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "냉장고 정보"),
      body: Center(child: Text("냉장고 정보 페이지")),
    );
  }
}
