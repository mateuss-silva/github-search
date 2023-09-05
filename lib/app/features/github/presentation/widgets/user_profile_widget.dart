import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      children: [
        const SizedBox(height: 16),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(user.avatarUrl),
          maxRadius: 128,
        ),
        const SizedBox(height: 8),
        Text(
          user.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          spacing: 8,
          children: user.socials
              .map((social) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        social.icon,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        social.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Visibility(
              visible: user.location != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.gps_fixed),
                    const SizedBox(width: 4),
                    Text(user.location ?? ''),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 4),
                Text("${user.followers} seguidores"),
                const SizedBox(width: 8),
                const Icon(Icons.circle, size: 8, color: Colors.black),
                const SizedBox(width: 8),
                const Icon(Icons.follow_the_signs),
                const SizedBox(width: 4),
                Text('${user.following} seguindo'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${user.publicRepos} Repositórios"),
            const SizedBox(width: 8),
            const Icon(Icons.circle, size: 8, color: Colors.black),
            const SizedBox(width: 8),
            Text("Membro desde ${user.createdAt.year}"),
          ],
        ),
        const SizedBox(height: 16),
        Text(user.bio ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
