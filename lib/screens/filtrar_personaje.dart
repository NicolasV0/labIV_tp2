import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp2_vaylet/models/respons_personaje.dart';
import 'package:tp2_vaylet/screens/busq_avanz_pers.dart';
import 'package:tp2_vaylet/screens/filtrar_personajes.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';

class FiltrarPersonaje extends StatefulWidget {
  const FiltrarPersonaje({super.key});

  @override
  State<FiltrarPersonaje> createState() => _FiltrarPersonajeState();
}

class _FiltrarPersonajeState extends State<FiltrarPersonaje> {
  Character? character;
  int usuarioId = 0;

  @override
  void initState() {
    super.initState();
    getPersonaje();
  }

  Future<void> getPersonaje() async {
    usuarioId++;
    final response =
        await Dio().get('https://rickandmortyapi.com/api/character/$usuarioId');
    character = Character.fromJson(response.data);
    setState(() {});
  }

  @override
  int selectedIndex = 0;

  final screens = [
    HomeScreen(),
    const FiltrarPersonajes(),
    const BuscarPersonaje()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaje'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(character?.name ?? 'No data'),
          Text(character?.gender ?? 'No data'),
          Text(character?.species ?? 'No data'),
          Text(character?.status ?? 'No data'),
          if (character != null) Image.network(character!.image),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          getPersonaje();
        },
      ),
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
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people_alt),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Busqueda',
          )
        ],
      ),
    );
  }
}
