import '../../../../core/entities/entity.dart';

base class SimplifiedUser extends Entity {
  final String avatarUrl;
  final String username;

  const SimplifiedUser({
    required super.id,
    required this.avatarUrl,
    required this.username,
  });

  @override
  List<Object?> get props => [
        id,
        avatarUrl,
        username,
      ];
}
