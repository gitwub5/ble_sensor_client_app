import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tag_viewmodel.dart';

class TagRegistrationScreen extends StatefulWidget {
  final String deviceName;
  final String remoteId;

  TagRegistrationScreen({required this.deviceName, required this.remoteId});

  @override
  _TagRegistrationScreenState createState() => _TagRegistrationScreenState();
}

class _TagRegistrationScreenState extends State<TagRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Duration? _selectedPeriod; // 감지 주기

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.deviceName); // 🔹 기본값 설정
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// 🔹 영어, 숫자만 입력 가능하도록 검증 (최대 8글자)
  String? _validateTagName(String? value) {
    if (value == null || value.isEmpty) {
      return "태그 이름을 입력하세요.";
    }
    if (value.length > 8) {
      return "최대 8글자까지 입력 가능합니다.";
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return "영어와 숫자만 입력 가능합니다.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final tagViewModel = Provider.of<TagViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tag 등록")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 RemoteId 및 DeviceName 표시
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // 연한 회색 배경
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Remote ID: ${widget.remoteId}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // 🔹 태그 이름 입력 설명
              Text(
                "등록할 기기의 이름을 입력하세요.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 12),

              // 🔹 태그 이름 입력 (연한 회색 배경 + 파란색 테두리)
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Tag ID",
                  hintText: "최대 8글자, 영어와 숫자만 가능",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  helperText: "예: Sensor01",
                  suffixIcon: _nameController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () =>
                              setState(() => _nameController.clear()),
                        )
                      : null,
                ),
                validator: _validateTagName,
                maxLength: 8, // 8글자 제한
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 24),

              // 🔹 감지 주기 설명 추가
              Text(
                "기기의 데이터를 전송할 간격을 설정하세요.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 12),

              // 🔹 감지 주기 선택 (흰색 배경 + 초록색 테두리)
              DropdownButtonFormField<Duration>(
                value: _selectedPeriod,
                decoration: InputDecoration(
                  labelText: "감지 주기",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                ),
                items: [
                  DropdownMenuItem(
                      value: Duration(minutes: 10), child: Text("10분")),
                  DropdownMenuItem(
                      value: Duration(minutes: 30), child: Text("30분")),
                  DropdownMenuItem(
                      value: Duration(hours: 1), child: Text("1시간")),
                  DropdownMenuItem(
                      value: Duration(hours: 3), child: Text("3시간")),
                  DropdownMenuItem(
                      value: Duration(hours: 6), child: Text("6시간")),
                  DropdownMenuItem(
                      value: Duration(hours: 12), child: Text("12시간")),
                ],
                onChanged: (value) => setState(() => _selectedPeriod = value),
                validator: (value) => value == null ? "감지 주기를 선택하세요." : null,
              ),
              SizedBox(height: 32),

              // 🔹 등록하기 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final currentTime = DateTime.now();
                      // 🔹 BLE 데이터 전송
                      await tagViewModel.writeData(
                        CommandType.setting,
                        latestTime: currentTime,
                        period: _selectedPeriod,
                        name: _nameController.text,
                      );

                      // 🔹 성공적으로 전송되면 DB 저장
                      await tagViewModel.addOrUpdateTag(
                        widget.remoteId,
                        _nameController.text,
                        _selectedPeriod!,
                        currentTime,
                      );

                      // 등록 완료 메시지
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("태그가 성공적으로 등록되었습니다!")),
                      );

                      Navigator.pop(context); // 이전 화면으로 이동
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("등록하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
