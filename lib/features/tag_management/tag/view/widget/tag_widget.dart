import 'package:bluetooth_app/features/tag_management/tag/view/tag_registration_screen.dart';
import 'package:bluetooth_app/features/tag_management/tag/viewmodel/tag_viewmodel.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/shared/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 추가된 부분
import 'dart:async';

class TagWidget extends StatefulWidget {
  final Tag tag;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEditName;
  final TagViewModel tagViewModel;

  const TagWidget({
    Key? key,
    required this.tag,
    required this.onTap,
    required this.onDelete,
    required this.onEditName,
    required this.tagViewModel,
  }) : super(key: key);

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  late Timer _timer;
  String _formattedTime = "";
  bool _isAdvertising = false;
  bool _isConnecting = false;
  TagDataData? _latestData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLatestData();
    _updateRemainingTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    final DateTime now = DateTime.now();
    final Duration elapsed = now.difference(widget.tag.updatedAt);
    final int elapsedSeconds = elapsed.inSeconds;

    const int cycleDuration = 1800; // 30분 = 1800초
    const int advertisingDuration = 30; // 광고 시간 30초

    final int timeInCycle = elapsedSeconds % cycleDuration;

    int remainingTime;
    if (timeInCycle < advertisingDuration) {
      remainingTime = advertisingDuration - timeInCycle;
      _isAdvertising = true;
    } else {
      remainingTime = cycleDuration - timeInCycle;
      _isAdvertising = false;
    }

    final minutes = remainingTime ~/ 60;
    final seconds = remainingTime % 60;
    _formattedTime =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    setState(() {});
  }

  void _connectToDevice() async {
    setState(() {
      _isConnecting = true;
    });

    bool success = await widget.tagViewModel.connectToDevice(
      widget.tag.remoteId,
      autoConnect: true,
      mtu: null,
    );

    setState(() {
      _isConnecting = false;
    });

    if (success) {
      print("✅ 연결 성공: ${widget.tag.remoteId}");
    } else {
      print("❌ 연결 실패: ${widget.tag.remoteId}");
    }
  }

  void _navigateToTagRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TagRegistrationScreen(
          deviceName: widget.tag.name,
          remoteId: widget.tag.remoteId,
        ),
      ),
    );
  }

  Future<void> _fetchLatestData() async {
    final data = await widget.tagViewModel.getLatestTagData(widget.tag.id);
    setState(() {
      _latestData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 4),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.tag.name} (${widget.tag.remoteId})",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "마지막 통신: ${formattedUpdatedAt(widget.tag.updatedAt)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'delete') widget.onDelete();
                          if (value == 'edit') widget.onEditName();
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('이름 수정'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('등록 해제'),
                          ),
                        ],
                        icon: Icon(Icons.more_vert, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "센서 주기: ${formattedSensorPeriod(widget.tag.sensorPeriod)}"),
                            Text(
                                "냉장고: ${widget.tag.refrigeratorId ?? 'Unknown'}"),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.blueAccent,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Icon(Icons.thermostat, color: Colors.red),
                                    SizedBox(width: 4),
                                    Text(
                                      _latestData != null
                                          ? "${_latestData!.temperature.toStringAsFixed(1)}°"
                                          : "N/A",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Icon(Icons.water_drop, color: Colors.blue),
                                    SizedBox(width: 4),
                                    Text(
                                      _latestData != null
                                          ? "${_latestData!.humidity.toStringAsFixed(1)}%"
                                          : "N/A",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Consumer<TagViewModel>(
                    builder: (context, tagViewModel, child) {
                      final isConnected =
                          tagViewModel.isDeviceConnected(widget.tag.remoteId);
                      final isConnecting = tagViewModel.connectingDevices
                          .contains(widget.tag.remoteId);

                      return Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _isAdvertising
                                  ? Colors.red
                                  : Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                _formattedTime,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          if (isConnected) ...[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isConnecting
                                    ? null
                                    : () async {
                                        await tagViewModel.disconnectDevice(
                                            widget.tag.remoteId);
                                        setState(() {}); // Refresh the UI
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text("연결 해제",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _navigateToTagRegistration,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text("재설정",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (isConnecting || _isConnecting)
                                    ? null
                                    : _connectToDevice,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: (isConnecting || _isConnecting)
                                    ? Text("연결 대기중",
                                        style: TextStyle(color: Colors.white))
                                    : Text("연결하기",
                                        style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
