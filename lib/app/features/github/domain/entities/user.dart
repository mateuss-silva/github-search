import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/entities/entity.dart';

base class User extends Entity {
  final String avatarUrl;
  final String username;
  final String? name;
  final String? location;
  final String? email;
  final String? bio;
  final String? twitterUsername;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final DateTime createdAt;

  List<({IconData icon, String value})> get socials => [
        (icon: FontAwesomeIcons.github, value: username),
        if (twitterUsername != null)
          (icon: FontAwesomeIcons.twitter, value: twitterUsername!),
        if (email != null) (icon: Icons.email, value: email!),
      ];

  const User({
    required super.id,
    required this.username,
    required this.avatarUrl,
    required this.name,
    required this.location,
    required this.email,
    required this.bio,
    required this.twitterUsername,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        avatarUrl,
        name,
        username,
        location,
        email,
        bio,
        twitterUsername,
        publicRepos,
        publicGists,
        followers,
        following,
        createdAt,
      ];
}
