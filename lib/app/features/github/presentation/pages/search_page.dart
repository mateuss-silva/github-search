import 'dart:async';

import 'package:flutter/material.dart';

import '../stores/github_store.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_result_widget.dart';
import '../widgets/user_profile_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {super.key, required this.store, required this.textController});

  final GitHubStore store;
  final TextEditingController textController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? timer;
  GitHubStore get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SearchBarWidget(
              controller: widget.textController,
              onChanged: (query) => _debounce(() => store.search(query)),
            )),
        ValueListenableBuilder(
            valueListenable: store,
            builder: (context, state, widget) {
              if (state is GitHubLoadingState) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 64.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is GitHubErrorState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 64.0, horizontal: 14.0),
                    child: Text(state.message),
                  ),
                );
              }

              if (state is GitHubLoadedState) {
                return SearchResultWidget(
                  result: state.users,
                  onTapUser: store.onSelectUser,
                );
              }

              if (state.user == null) return Container();

              return Expanded(child: UserProfileWidget(user: state.user!));
            }),
      ],
    );
  }

  void _debounce(VoidCallback search) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), search);
  }
}
