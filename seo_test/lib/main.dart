import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:seo_test/api_service.dart';
import 'package:seo_test/details_screen.dart';
import 'package:seo_test/list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(
      module: AppModule(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ApiService(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OG Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds {
    return [];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        ListScreen.routeName,
        child: (_, __) => const ListScreen(),
      ),
      ChildRoute(
        DetailsScreen.routeName,
        child: (_, args) => DetailsScreen(
          id: int.parse(
            args.params['id'].toString(),
          ),
        ),
      )
    ];
  }
}
