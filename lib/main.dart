import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/view/berita/baca.dart';
import 'package:smartcity/view/berita/berita.dart';
import 'package:smartcity/view/index.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: MainApp.nameRoute,
      routes: {
        Berita.nameRoute: (context) => const Berita(),
        MainApp.nameRoute: (context) => const MainApp(),
        BacaBerita.nameRoute: (context) => BacaBerita(
            e: ModalRoute.of(context)?.settings.arguments as dynamic),
      },
    );
  }
}
