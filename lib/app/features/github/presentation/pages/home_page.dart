import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/github_datasource_impl.dart';
import '../../data/datasources/history_datasource_impl.dart';
import '../../data/repositories/github_repository_impl.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/entities/history.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';
import '../stores/github_store.dart';
import 'history_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final dio = Dio();
  final history = HistoryRepositoryImpl(HistoryDataSourceImpl());
  late final github = GitHubRepositoryImpl(GitHubDataSourceImpl(dio));
  late final githubStore =
      GitHubStore(SearchUsersUsecase(github, history), GetUserUsecase(github));

  final searchController = TextEditingController();
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Users'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Usuários'),
              Tab(text: 'Histórico'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SearchPage(
              store: githubStore,
              textController: searchController,
            ),
            HistoryPage(onTapHistory: _onTapHistory),
          ],
        ),
      ),
    );
  }

  void _onTapHistory(History history) {
    searchController.text = history.query;
    githubStore.search(history.query);
    _tabController.animateTo(0);
  }
}
