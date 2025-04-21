import 'package:flutter/material.dart';

class HistoriaPage extends StatelessWidget {
  final String historiaTexto = '''
La Defensa Civil de la República Dominicana fue fundada con el objetivo de proteger y asistir a la población ante desastres naturales y emergencias. A lo largo de los años, ha jugado un papel fundamental en situaciones críticas como huracanes, terremotos e inundaciones.

Desde su creación, la institución ha promovido la prevención, la educación comunitaria y la respuesta rápida ante emergencias. Con el apoyo de miles de voluntarios y personal capacitado, la Defensa Civil se ha convertido en una de las entidades más importantes en la gestión de riesgos del país.

Gracias a su compromiso y evolución constante, hoy en día cuenta con unidades de rescate, centros de operación, programas de formación y tecnología para atender cualquier situación que ponga en riesgo a la ciudadanía.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            historiaTexto,
            style: TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
