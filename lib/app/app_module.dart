import 'package:flutter_modular/flutter_modular.dart';

import 'features/github/github_module.dart';

class AppModule extends Module {

  @override
  void routes(r) {
    r.module('/', module: GitHubModule());
  }
}
