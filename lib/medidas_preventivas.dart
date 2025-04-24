import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedidasPreventivasPage extends StatefulWidget {
  @override
  _MedidasPreventivasPageState createState() => _MedidasPreventivasPageState();
}

class _MedidasPreventivasPageState extends State<MedidasPreventivasPage> {
  List medidas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerMedidas();
  }

  Future<void> obtenerMedidas() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/medidas_preventivas.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        medidas = datos['datos'];
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
      appBar: AppBar(title: Text('Medidas Preventivas')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: medidas.length,
              itemBuilder: (context, index) {
                final item = medidas[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(item['titulo'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['descripcion']),
                    leading: Icon(Icons.warning, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
