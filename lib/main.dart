import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recall_table/features/home/presentation/screens/recall_table_screen.dart';
import 'package:recall_table/features/learn/domain/number.dart';
import 'package:recall_table/features/learn/presentation/screens/learn_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = "/assets/db";
  if (!kIsWeb) {
    var appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
  }

  await Hive.initFlutter();
  Hive.init(path);
  Hive.registerAdapter(NumberImplAdapter());

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RecallTableScreen(),
      ),
      GoRoute(
        path: '/learn',
        builder: (context, state) => const LearnScreen(),
      ),
    ],
  );

  runApp(ProviderScope(child: RecallApp(router: router)));
}

class RecallApp extends StatelessWidget {
  final GoRouter router;
  const RecallApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Recall App',
      debugShowCheckedModeBanner: false,
    );
  }
}
