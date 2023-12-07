import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_vaylet/providers/theme.dart';
import 'package:tp2_vaylet/screens/busq_avanz_pers.dart';
import 'package:tp2_vaylet/screens/filtrar_personaje.dart';
import 'package:tp2_vaylet/screens/filtrar_personajes.dart';

var press = false;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final screens = [
    const FiltrarPersonaje(),
    const FiltrarPersonajes(),
    const BuscarPersonaje()
  ];

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
      body: Screen(size: size),
      backgroundColor: Colors.black26,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => screens[selectedIndex]));
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Personaje',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people_alt),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search_outlined),
            label: 'Busqueda',
          )
        ],
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: size.height * 0.89,
            width: size.width * 0.99,
            child: Image.asset('assets/rick_morty_home.gif', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
