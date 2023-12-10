import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp2_vaylet/models/respons_personaje.dart';
import 'package:tp2_vaylet/screens/busq_avanz_pers.dart';
import 'package:tp2_vaylet/screens/filtrar_personajes.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['API_KEY'];

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
    try {
      final response = await Dio().get(
        'https://apirender-g-v-2023.onrender.com/api/v1/rickandmorty/personaje/$usuarioId?api_key=$apiKey',
      );
      if (response.statusCode == 200) {
        character = Character.fromJson(response.data);
      }
    } catch (error) {
      const Text('Error al obtener el personaje');
    } finally {
      setState(() {});
    }
  }

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
      body: Card(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (character != null)
              Image.network(
                character!.data.image,
                fit: BoxFit.fill,
                width: 400,
                height: 400,
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              character?.data.name ?? 'No data',
              style: const TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Text('Genero: ${character?.data.gender ?? 'No data'}'),
            Text('Especie: ${character?.data.species ?? 'No data'}'),
            Text('Estado: ${character?.data.status ?? 'No data'}'),
          ]),
        ),
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
