import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/datasources/history_datasource_impl.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/entities/history.dart';
import '../../domain/usecases/get_history.dart';
import '../stores/history_store.dart';

class HistoryPage extends StatefulWidget {
  final Function(History) onTapHistory;
  const HistoryPage({
    super.key,
    required this.onTapHistory,
  });

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

  void Function(History) get onTapHistory => widget.onTapHistory;

  final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

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
                    leading: const Icon(Icons.history),
                    title: Text(history.query),
                    subtitle: Text(formatter.format(history.createdAt)),
                    onTap: () => onTapHistory(history),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
// TODO ● Código Testável (unit test)
// TODO ● Como rodar sua aplicação
// TODO ● Padrões de Projeto 
