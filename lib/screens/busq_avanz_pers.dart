import 'package:flutter/material.dart';
import 'package:tp2_vaylet/screens/filtrar_personaje.dart';
import 'package:tp2_vaylet/screens/filtrar_personajes.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';
import 'package:tp2_vaylet/screens/result_busq.dart';

class BuscarPersonaje extends StatefulWidget {
  const BuscarPersonaje({super.key});

  @override
  State<BuscarPersonaje> createState() => _BuscarPersonajeState();
}

class _BuscarPersonajeState extends State<BuscarPersonaje> {
  final _textNombre = TextEditingController();
  String userSearch = '';
  String name = '';
  String estatus = '';
  String especie = '';

  int selectedIndex = 0;
  final screens = [
    HomeScreen(),
    const FiltrarPersonajes(),
    const FiltrarPersonaje(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Personaje'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                userSearch,
                style: const TextStyle(fontSize: 36),
              ))),
              TextField(
                controller: _textNombre,
                decoration: InputDecoration(
                    hintText: 'Nombre personaje',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _textNombre.clear();
                        },
                        icon: const Icon(Icons.clear))),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    userSearch = _textNombre.text;
                    List<String> cadena = userSearch.split(',');
                    name = cadena[0].trim();
                    estatus = cadena[1].trim();
                    especie = cadena[2].trim();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResultBusqueda(name, estatus, especie)));
                  });
                },
                color: Colors.blue,
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
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
            icon: Icon(Icons.person_3_outlined),
            activeIcon: Icon(Icons.person_3),
            label: 'Personaje',
          )
        ],
      ),
    );
  }
}
