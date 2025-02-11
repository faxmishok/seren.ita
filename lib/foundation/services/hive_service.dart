import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:serenita/foundation/models/hive_adapters/user_info_hive.dart';

class HiveService {
  late Box<dynamic> userRelatedBox;

  bool _compactionStrategy(int entriesLength, int changedEntriesLength) {
    return changedEntriesLength > 50;
  }

  Future<void> init() async {

    if (kIsWeb) {
      const directory = 'assets/db';
      const path = directory;
      Hive.init(path);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      Hive.init(path);
    }

    Hive.registerAdapter(UserInfoHiveAdapter());

    userRelatedBox = await Hive.openBox<dynamic>(
      'user_related',
      compactionStrategy: _compactionStrategy,
    );

    userRelatedBox.watch().listen((BoxEvent event) {});

    debugPrint('initialised');
  }

  void close() {
    Hive.close();
  }
}
