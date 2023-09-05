import 'dart:async';

import 'package:flutter/material.dart';

import '../stores/github_store.dart';
import '../widgets/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.store, required this.textController});

  final GitHubStore store;
  final  TextEditingController textController ;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Timer? timer;
  GitHubStore get store  => widget.store;

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
                final result = state.users;
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
                            onTap: () => store.onSelectUser(user),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatarUrl),
                            ),
                            title: Text(user.username),
                          ),
                        );
                      }),
                );
              }

              if (state.user == null) return Container();

              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(state.user!.avatarUrl),
                      maxRadius: 128,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.user!.name ?? '',
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
                      children: state.user!.socials
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
                          visible: state.user!.location != null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.gps_fixed),
                                const SizedBox(width: 4),
                                Text(state.user!.location ?? ''),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.people),
                            const SizedBox(width: 4),
                            Text("${state.user!.followers} seguidores"),
                            const SizedBox(width: 8),
                            const Icon(Icons.circle,
                                size: 8, color: Colors.black),
                            const SizedBox(width: 8),
                            const Icon(Icons.follow_the_signs),
                            const SizedBox(width: 4),
                            Text('${state.user!.following} seguindo'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${state.user!.publicRepos} Repositórios"),
                        const SizedBox(width: 8),
                        const Icon(Icons.circle, size: 8, color: Colors.black),
                        const SizedBox(width: 8),
                        Text("Membro desde ${state.user!.createdAt.year}"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(state.user!.bio ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

  void _debounce(VoidCallback search) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), search);
  }
}
