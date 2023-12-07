import 'package:flutter/material.dart';
import 'package:tp2_vaylet/providers/theme.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(ThemeData.dark()),
      child: const MaterialAppWithWidget(),
    );
  }

  // This widget is the root of your application.
}

class MaterialAppWithWidget extends StatelessWidget {
  const MaterialAppWithWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Practico 2',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
      },
    );
  }
}
