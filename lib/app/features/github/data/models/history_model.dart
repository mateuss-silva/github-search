import '../../../../core/common/types.dart';
import '../../domain/entities/history.dart';

final class HistoryModel extends History {
  const HistoryModel({
    required super.id,
    required super.query,
    required super.createdAt,
  });

  factory HistoryModel.fromJson(Json json) {
    return HistoryModel(
      id: json['id'] as int,
      query: json['query'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Json toJson() {
    return {
      'id': id,
      'query': query,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
