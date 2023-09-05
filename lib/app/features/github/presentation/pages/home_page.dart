import 'package:flutter/material.dart';

import 'history_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Users'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Usuários'),
              Tab(text: 'Histórico'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SearchPage(),
            HistoryPage(),
          ],
        ),
      ),
    );
  }
}
