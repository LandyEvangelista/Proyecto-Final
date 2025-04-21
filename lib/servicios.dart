import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  List servicios = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerServicios();
  }

  Future<void> obtenerServicios() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/servicios.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        servicios = datos['datos'];
        cargando = false;
      });
    } else {
      // Manejo de error
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Servicios')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: servicios.length,
              itemBuilder: (context, index) {
                final servicio = servicios[index];
                return ListTile(
                  title: Text(servicio['titulo']),
                  subtitle: Text(servicio['descripcion']),
                  leading: Icon(Icons.miscellaneous_services),
                );
              },
            ),
    );
  }
}
