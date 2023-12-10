import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tp2_vaylet/models/respons_allpersonajes.dart';
import 'package:tp2_vaylet/screens/busq_avanz_pers.dart';
import 'package:tp2_vaylet/screens/filtrar_personaje.dart';
import 'package:tp2_vaylet/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['API_KEY'];

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
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/buscando2.gif',
                          fit: BoxFit.cover,
                        )),
                    const Text('Viajando a la velocidad de la luz...')
                  ],
                ),
              );
            } else if (snapshot.data?.status == 200) {
              return _ListaPersonajes(snapshot.data!.results);
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/not_found.gif',
                          fit: BoxFit.cover,
                        )),
                    const Text('Personaje not found')
                  ],
                ),
              );
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
    return GridView.count(
      crossAxisCount:
          2, // Adjust the number of columns according to your preference
      childAspectRatio: 1.0, // Set the aspect ratio of each grid item
      children: result.map((resultado) {
        return FadeInLeft(
          delay: Duration(milliseconds: 50 * result.indexOf(resultado)),
          child: Card(
            child: Column(children: [
              Expanded(
                child: Image.network(
                  resultado.image,
                  fit: BoxFit.fill,
                ),
              ),
              Text(resultado.name)
            ]),
          ),
        );
      }).toList(),
    );
  }
}

Future<Personajes> getPersonajes() async {
  final resp = await http.get(Uri.parse(
      'https://apirender-g-v-2023.onrender.com/api/v1/rickandmorty/personajes?api_key=$apiKey'));
  return personajesFromJson(resp.body);
}
