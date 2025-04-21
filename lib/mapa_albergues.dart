import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class MapaAlberguesPage extends StatefulWidget {
  @override
  _MapaAlberguesPageState createState() => _MapaAlberguesPageState();
}

class _MapaAlberguesPageState extends State<MapaAlberguesPage> {
  List albergues = [];
  List<Marker> marcadores = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerAlbergues();
  }

  Future<void> obtenerAlbergues() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/albergues.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      List<Marker> temp = [];

      for (var a in datos['datos']) {
        double lat = double.tryParse(a['latitud']) ?? 0.0;
        double lng = double.tryParse(a['longitud']) ?? 0.0;

        if (lat != 0.0 && lng != 0.0) {
          temp.add(
            Marker(
              point: LatLng(lat, lng),
              width: 35,
              height: 35,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(a['colegio']),
                      content: Text(
                          'Provincia: ${a['provincia']}\nMunicipio: ${a['municipio']}\nSector: ${a['sector']}\nCapacidad: ${a['capacidad']} personas'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Icons.location_pin, color: Colors.orange, size: 35),
              ),
            ),
          );
        }
      }

      setState(() {
        albergues = datos['datos'];
        marcadores = temp;
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
      appBar: AppBar(title: Text('Mapa de Albergues')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(18.7357, -70.1627),
                initialZoom: 7.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: marcadores),
              ],
            ),
    );
  }
}
