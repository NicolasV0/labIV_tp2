import 'package:flutter/material.dart';
import 'package:tp2_vaylet/models/respons_allpersonajes.dart';
import 'package:tp2_vaylet/screens/busq_avanz_pers.dart';
import 'package:tp2_vaylet/screens/filtrar_personaje.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class FiltrarPersonajes extends StatefulWidget {
  const FiltrarPersonajes({super.key});

  @override
  State<FiltrarPersonajes> createState() => _FiltrarPersonajesState();
}

class _FiltrarPersonajesState extends State<FiltrarPersonajes> {
  int selectedIndex = 0;

  final screens = [
    HomeScreen(),
    const FiltrarPersonaje(),
    const BuscarPersonaje()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getPersonajes(),
          builder: (BuildContext context, AsyncSnapshot<Personajes> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _ListaPersonajes(snapshot.data!.results);
            }
          }),
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
            icon: Icon(Icons.person_3_outlined),
            activeIcon: Icon(Icons.person_3),
            label: 'Personaje',
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

class _ListaPersonajes extends StatelessWidget {
  final List<Result> result;
  const _ListaPersonajes(this.result);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: result.length + 1,
        itemBuilder: (BuildContext context, int i) {
          final resultados = result[i];
          return ListTile(
            title: Text('${resultados.name} (${resultados.status.name})'),
            subtitle: Text(resultados.gender.name),
            trailing: Image.network(resultados.image),
          );
        });
  }
}

Future<Personajes> getPersonajes() async {
  final resp = await http.get(Uri.parse(
      'https://apirender-g-v-2023.onrender.com/api/v1/rickandmorty/personajes?api_key=123asdlk1981'));
  return personajesFromJson(resp.body);
}
