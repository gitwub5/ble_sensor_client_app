import 'package:flutter/material.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/repository/tag_data_repository.dart';

class TagDataViewModel extends ChangeNotifier {
  final TagDataRepository _tagDataRepository;
  List<TagDataData> _tagDataList = [];
  bool _isLoading = false;

  List<TagDataData> get tagDataList => _tagDataList;
  bool get isLoading => _isLoading;

  TagDataViewModel(this._tagDataRepository);

  Future<void> fetchTagData(int tagId) async {
    _isLoading = true;
    notifyListeners();

    _tagDataList = await _tagDataRepository.getTagData(tagId);

    _isLoading = false;
    notifyListeners();
  }
}
