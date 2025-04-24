import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MiembrosPage extends StatefulWidget {
  @override
  _MiembrosPageState createState() => _MiembrosPageState();
}

class _MiembrosPageState extends State<MiembrosPage> {
  List miembros = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerMiembros();
  }

  Future<void> obtenerMiembros() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/miembros.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        miembros = datos['datos'];
        cargando = false;
      });
    } else {
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Miembros de la Defensa Civil')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: miembros.length,
              itemBuilder: (context, index) {
                final miembro = miembros[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(miembro['nombre'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Cargo: ${miembro['cargo']}'),
                    leading: Icon(Icons.person, color: Colors.blue),
                    isThreeLine: true,
                    onTap: () {
                      // Aquí podríamos mostrar más detalles si lo deseas
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(miembro['nombre']),
                          content: Text('Cargo: ${miembro['cargo']}\n\nDescripción: ${miembro['descripcion']}'),
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
    );
  }
}
