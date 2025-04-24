import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlberguesPage extends StatefulWidget {
  @override
  _AlberguesPageState createState() => _AlberguesPageState();
}

class _AlberguesPageState extends State<AlberguesPage> {
  List albergues = [];
  List alberguesFiltrados = [];
  bool cargando = true;
  TextEditingController busquedaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerAlbergues();
  }

  Future<void> obtenerAlbergues() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/albergues.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        albergues = datos['datos'];
        alberguesFiltrados = albergues;
        cargando = false;
      });
    } else {
      setState(() {
        cargando = false;
      });
    }
  }

  void filtrarAlbergues(String query) {
    final filtrados = albergues.where((albergue) {
      final nombre = albergue['colegio'].toLowerCase();
      final sector = albergue['sector'].toLowerCase();
      final input = query.toLowerCase();
      return nombre.contains(input) || sector.contains(input);
    }).toList();

    setState(() {
      alberguesFiltrados = filtrados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Albergues')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: busquedaController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por colegio o sector',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: filtrarAlbergues,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: alberguesFiltrados.length,
                    itemBuilder: (context, index) {
                      final item = alberguesFiltrados[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(item['colegio'] ?? 'Sin nombre'),
                          subtitle: Text('Municipio: ${item['municipio'] ?? 'N/D'}\nSector: ${item['sector'] ?? 'N/D'}'),
                          isThreeLine: true,
                          leading: Icon(Icons.home),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(item['colegio'] ?? 'Sin nombre'),
                                  content: Text(
                                  'Provincia: ${item['provincia'] ?? 'N/D'}\nMunicipio: ${item['municipio'] ?? 'N/D'}\nSector: ${item['sector'] ?? 'N/D'}\nCapacidad: ${item['capacidad'] ?? 'N/D'} personas'),
                                  actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cerrar'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
