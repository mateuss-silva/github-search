import 'package:flutter/material.dart';

import '../../data/datasources/history_datasource_impl.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/usecases/get_history.dart';
import '../stores/history_store.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final store = HistoryStore(
      GetHistoryUsecase(HistoryRepositoryImpl(HistoryDataSourceImpl())));

  @override
  void initState() {
    super.initState();
    store.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: store,
          builder: (context, state, widget) {
            if (state is HistoryLoadingState) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is HistoryErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 64.0, horizontal: 14.0),
                  child: Text(state.message),
                ),
              );
            }
            if (state is HistoryLoadedState) {
              return ListView.builder(
                itemCount: state.history.length,
                itemBuilder: (context, index) {
                  final history = state.history[index];
                  return ListTile(
                    title: Text(history.query),
                    subtitle: Text(history.createdAt.toIso8601String()),
                    onTap: () => store.onSelectHistory(history),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
