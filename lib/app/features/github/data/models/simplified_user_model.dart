import '../../../../core/common/types.dart';
import '../../domain/entities/simplified_user.dart';

final class SimplifiedUserModel extends SimplifiedUser {
  const SimplifiedUserModel({
    required super.id,
    required super.avatarUrl,
    required super.username,
  });

  factory SimplifiedUserModel.fromJson(Json json) => SimplifiedUserModel(
        id: json['id'],
        avatarUrl: json['avatar_url'],
        username: json['login'],
      );

  Json toJson() => {
        'id': id,
        'avatar_url': avatarUrl,
        'login': username,
      };

  static List<SimplifiedUserModel> fromJsonList(List jsonList) =>
      jsonList.map((json) => SimplifiedUserModel.fromJson(json)).toList();
}
