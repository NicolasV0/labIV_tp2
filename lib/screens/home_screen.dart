import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_vaylet/providers/theme.dart';

var press = false;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        centerTitle: true,
        actions: [
          FloatingActionButton(
            mini: true,
            child: const Icon(Icons.switch_left),
            onPressed: () {
              if (press == false) {
                theme.setTheme(ThemeData.light());
                press = true;
              } else {
                theme.setTheme(ThemeData.dark());
                press = false;
              }
            },
          ),
          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.89,
              width: size.width * 0.99,
              child:
                  Image.asset('assets/rick_morty_home.gif', fit: BoxFit.cover),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black26,
    );
  }
}
