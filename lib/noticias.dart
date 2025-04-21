import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  List noticias = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerNoticias();
  }

  Future<void> obtenerNoticias() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/noticias.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        noticias = datos['datos'];
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
      appBar: AppBar(title: Text('Noticias')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(noticia['titulo']),
                    subtitle: Text(noticia['descripcion']),
                    leading: Icon(Icons.article_outlined),
                  ),
                );
              },
            ),
    );
  }
}
