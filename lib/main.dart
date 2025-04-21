import 'package:flutter/material.dart';
import 'inicio.dart';
import 'historia.dart';
import 'servicios.dart';
import 'noticias.dart';
import 'videos.dart';
import 'albergues.dart';
import 'mapa_albergues.dart';
import 'medidas_preventivas.dart';
import 'miembros.dart';
import 'voluntariado.dart';

void main() {
  runApp(MiAppDefensaCivil());
}

class MiAppDefensaCivil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defensa Civil',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MenuPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  final List<Map<String, dynamic>> opciones = [
    {'titulo': 'Inicio', 'widget': InicioPage()},
    {'titulo': 'Historia', 'widget': HistoriaPage()},
    {'titulo': 'Servicios', 'widget': ServiciosPage()},
    {'titulo': 'Noticias', 'widget': NoticiasPage()},
    {'titulo': 'Videos', 'widget': VideosPage()},
    {'titulo': 'Albergues', 'widget': AlberguesPage()},
    {'titulo': 'Mapa de Albergues', 'widget': MapaAlberguesPage()},
    {'titulo': 'Medidas Preventivas', 'widget': MedidasPreventivasPage()},
    {'titulo': 'Miembros', 'widget': MiembrosPage()},
    {'titulo': 'Quiero ser Voluntario', 'widget': VoluntariadoPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Defensa Civil RD')),
      body: ListView.builder(
        itemCount: opciones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(opciones[index]['titulo']),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => opciones[index]['widget']),
              );
            },
          );
        },
      ),
    );
  }
}
