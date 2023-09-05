import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/history_page.dart';
import 'presentation/pages/home_page.dart';

class GitHubModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/history', child: (_) => const HistoryPage());
  }
}
