import 'package:flutter/material.dart';
import 'package:github_search/app/features/github/domain/entities/simplified_user.dart';

class SearchResultWidget extends StatelessWidget {
  final List<SimplifiedUser> result;
  final Function(SimplifiedUser) onTapUser;
  const SearchResultWidget(
      {super.key, required this.result, required this.onTapUser});

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return const Expanded(
        child: Center(child: Text('No users found :(')),
      );
    }

    return Expanded(
      child: ListView.separated(
          itemCount: result.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final user = result[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: ListTile(
                onTap: () => onTapUser(user),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
                title: Text(user.username),
              ),
            );
          }),
    );
  }
}
