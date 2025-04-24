import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapaAlberguesPage extends StatefulWidget {
  @override
  _MapaAlberguesPageState createState() => _MapaAlberguesPageState();
}

class _MapaAlberguesPageState extends State<MapaAlberguesPage> {
  List<Marker> marcadores = [];
  bool cargando = true;

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
      List<Marker> temp = [];

      for (var a in datos['datos']) {
        double? lat = double.tryParse(a['latitud'] ?? '');
        double? lng = double.tryParse(a['longitud'] ?? '');

        if (lat != null && lng != null && lat != 0.0 && lng != 0.0) {
          temp.add(
            Marker(
              width: 40,
              height: 40,
              point: LatLng(lat, lng),
              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          );
        }
      }

      setState(() {
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
                initialCenter: LatLng(18.7357, -70.1627), // Centro RD
                initialZoom: 7.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "com.example.app",
                ),
                MarkerLayer(markers: marcadores),
              ],
            ),
    );
  }
}
