import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/history.dart';
import '../models/history_model.dart';
import 'history_datasource.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  @override
  Future<bool> add(String query) async {
    try {
      final newHistoryItem = HistoryModel(
        id: await _generateId(),
        createdAt: DateTime.now(),
        query: query,
      );

      await _addNewHistoryItem(newHistoryItem);

      return true;
    } catch (e) {
      throw LocalStoreException();
    }
  }

  @override
  Future<List<History>> getHistory() {
    try {
      return _getHistory();
    } catch (e) {
      throw LocalStoreException();
    }
  }

  Future<void> _addNewHistoryItem(HistoryModel item) async {
    final preferences = await SharedPreferences.getInstance();
    final history = await _getHistory();
    history.add(item);

    await preferences.setStringList(
      'history',
      history.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<List<HistoryModel>> _getHistory() async {
    final preferences = await SharedPreferences.getInstance();
    final history = preferences.getStringList('history');
    if (history == null) {
      return [];
    }
    return history.map((e) => HistoryModel.fromJson(jsonDecode(e))).toList();
  }

  Future<int> _generateId() async {
    final history = await _getHistory();
    if (history.isEmpty) {
      return 1;
    }
    return history.last.id + 1;
  }
}
