import '../../domain/entities/history.dart';

abstract interface class HistoryDataSource{
  Future<List<History>> getHistory();
  Future<bool> add(String query);
}