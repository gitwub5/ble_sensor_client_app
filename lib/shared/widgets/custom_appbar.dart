import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leftButton;
  final Widget? rightButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leftButton,
    this.rightButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 왼쪽 버튼 (Optional)
              leftButton ?? SizedBox(width: 48), // 없으면 빈 공간으로 처리

              /// 타이틀
              Text(
                title,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              /// 오른쪽 버튼 (Optional)
              rightButton ?? SizedBox(width: 48), // 없으면 빈 공간으로 처리
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.0);
}
