import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home.dart';
import 'webkota/views/berita/index.dart';
import 'webkota/views/berita/baca.dart';
import 'webkota/views/pesan/index.dart';
import 'webkota/views/webview/index.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'SPN Central Service',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: Home.nameRoute,
      routes: {
        Home.nameRoute: (context) => const Home(),
        Berita.nameRoute: (context) => const Berita(),
        BacaBerita.nameRoute: (context) => BacaBerita(
            e: ModalRoute.of(context)?.settings.arguments as dynamic),
        Pesan.nameRoute: (context) => const Pesan(),
        ServiceView.nameRoute: (context) => const ServiceView(),
      },
    );
  }
}
