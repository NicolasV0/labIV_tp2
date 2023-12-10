import 'package:flutter/material.dart';
import 'package:tp2_vaylet/models/busq_avanzada.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['API_KEY'];

class ResultBusqueda extends StatefulWidget {
  final String name, estatus, especie;
  const ResultBusqueda(this.name, this.estatus, this.especie, {super.key});

  @override
  State<ResultBusqueda> createState() => _ResultBusquedaState();
}

class _ResultBusquedaState extends State<ResultBusqueda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getResultado(widget.name, widget.estatus, widget.especie),
          builder:
              (BuildContext context, AsyncSnapshot<BusquedaAvanzada> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/buscando.gif',
                  fit: BoxFit.cover,
                ),
              ));
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
    );
  }
}

class _ListaPersonajes extends StatelessWidget {
  final List<Result> result;
  const _ListaPersonajes(this.result);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: result.length,
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

Future<BusquedaAvanzada> getResultado(
    String name, String estado, String especie) async {
  final resp = await http.get(Uri.parse(
      'https://apirender-g-v-2023.onrender.com/api/v1/rickandmorty/filtrar-personajes/?nombre=$name&status=$estado&species=$especie&api_key=$apiKey'));
  return busquedaAvanzadaFromJson(resp.body);
}
