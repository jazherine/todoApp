import 'package:flutter/material.dart';

import 'package:todoapp/ui/view/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
      },
    );
  }
}
