import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InicioPage extends StatelessWidget {
  final List<Map<String, String>> sliderItems = [
    {
      'titulo': 'Emergencias 24/7',
      'imagen': 'assets/emergencias.png',
    },
    {
      'titulo': 'Capacitaciones Continuas',
      'imagen': 'assets/capacitacion.jpg',
    },
    {
      'titulo': 'Rescate y Auxilio',
      'imagen': 'assets/rescate.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Column(
        children: [
          SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: sliderItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            item['imagen']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(8),
                            child: Text(
                              item['titulo']!,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
