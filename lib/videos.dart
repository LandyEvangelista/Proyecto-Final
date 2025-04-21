import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List videos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerVideos();
  }

  Future<void> obtenerVideos() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/videos.php");
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      setState(() {
        videos = datos['datos'];
        cargando = false;
      });
    } else {
      setState(() {
        cargando = false;
      });
    }
  }

  Future<void> abrirVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No se pudo abrir el video.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Videos')),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(video['titulo']),
                    subtitle: Text('Presiona para ver'),
                    leading: Icon(Icons.play_circle_fill, color: Colors.red),
                    onTap: () => abrirVideo(video['link']),
                  ),
                );
              },
            ),
    );
  }
}
