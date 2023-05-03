import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcity/berita/baca.dart';

import 'berita/berita.dart';
import 'berita/index.dart';
import 'models/berita_model.dart';

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
      initialRoute: HomePage.nameRoute,
      routes: {
        HomePage.nameRoute: (context) => HomePage(),
        Berita.nameRoute: (context) => const Berita(),
        BacaBerita.nameRoute: (context) => BacaBerita(
            e: ModalRoute.of(context)?.settings.arguments as Payload),
      },
    );
  }
}
