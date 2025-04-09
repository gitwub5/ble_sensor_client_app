import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:bluetooth_app/shared/widgets/custom_appbar.dart';
import 'package:bluetooth_app/shared/widgets/custom_snackbar.dart';
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
  Duration? _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.deviceName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _validateTagName(String? value) {
    if (value == null || value.isEmpty) {
      return "태그 이름을 입력하세요.";
    }
    if (value.length > 10) {
      return "최대 10글자까지 입력 가능합니다.";
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
      appBar: CustomAppBar(
        title: "기기 등록",
        leftButton: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                ),
                SizedBox(height: 24),
                Text(
                  "등록할 기기의 이름을 입력하세요.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Tag ID",
                    hintText: "최대 10글자, 영어와 숫자만 가능",
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
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 24),
                Text(
                  "기기의 데이터를 전송할 간격을 설정하세요.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 12),
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
                        value: Duration(minutes: 5), child: Text("5분")),
                    DropdownMenuItem(
                        value: Duration(minutes: 10), child: Text("10분")),
                    DropdownMenuItem(
                        value: Duration(minutes: 30), child: Text("30분")),
                    DropdownMenuItem(
                        value: Duration(hours: 1), child: Text("1시간")),
                    DropdownMenuItem(
                        value: Duration(hours: 2), child: Text("2시간")),
                    DropdownMenuItem(
                        value: Duration(hours: 3), child: Text("3시간")),
                  ],
                  onChanged: (value) => setState(() => _selectedPeriod = value),
                  validator: (value) => value == null ? "감지 주기를 선택하세요." : null,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final currentTime = DateTime.now();

              await tagViewModel.writeData(
                widget.remoteId,
                commandType: CommandType.setting,
                latestTime: currentTime,
                period: _selectedPeriod!,
              );

              await tagViewModel.addOrUpdateTag(
                widget.remoteId,
                _nameController.text,
                _selectedPeriod!,
                currentTime,
              );

              await tagViewModel.disconnectDevice(widget.remoteId);

              CustomSnackbar.show(
                context,
                "태그가 성공적으로 등록되었습니다!",
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );

              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text("등록하기"),
        ),
      ),
    );
  }
}
