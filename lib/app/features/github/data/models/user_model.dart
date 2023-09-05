import '../../../../core/common/types.dart';
import '../../domain/entities/user.dart';

final class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatarUrl,
    required super.name,
    required super.username,
    required super.location,
    required super.email,
    required super.bio,
    required super.twitterUsername,
    required super.publicRepos,
    required super.publicGists,
    required super.followers,
    required super.following,
    required super.createdAt,
  });

  factory UserModel.fromJson(Json json) => UserModel(
        id: json['id'],
        avatarUrl: json['avatar_url'],
        name: json['name'],
        username: json['login'],
        location: json['location'],
        email: json['email'],
        bio: json['bio'],
        twitterUsername: json['twitter_username'],
        publicRepos: json['public_repos'],
        publicGists: json['public_gists'],
        followers: json['followers'],
        following: json['following'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Json toJson() => {
        'id': id,
        'avatar_url': avatarUrl,
        'name': name,
        'login': username,
        'location': location,
        'email': email,
        'bio': bio,
        'twitter_username': twitterUsername,
        'public_repos': publicRepos,
        'public_gists': publicGists,
        'followers': followers,
        'following': following,
        'created_at': createdAt.toIso8601String(),
      };

  static List<UserModel> fromJsonList(List jsonList) =>
      jsonList.map((json) => UserModel.fromJson(json)).toList();
}
