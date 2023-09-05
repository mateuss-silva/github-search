import '../../../../core/entities/entity.dart';

base class History extends Entity {
  final String query;
  final DateTime createdAt;

  const History({
    required super.id,
    required this.query,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, query, createdAt];
}
