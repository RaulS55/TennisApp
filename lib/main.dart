import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/src/routes/pages.dart';
import 'package:tenis_app/src/ui/pages/home/home_controller.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => HomeController(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenis app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      initialRoute: Pages.INITIAL,
      routes: Pages.routes,
    );
  }
}
