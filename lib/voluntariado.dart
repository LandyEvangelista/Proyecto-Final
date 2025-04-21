import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoluntariadoPage extends StatefulWidget {
  @override
  _VoluntariadoPageState createState() => _VoluntariadoPageState();
}

class _VoluntariadoPageState extends State<VoluntariadoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController comentariosController = TextEditingController();
  
  bool _cargando = false;

  Future<void> enviarFormulario() async {
    setState(() {
      _cargando = true;
    });

    final url = Uri.parse("https://adamix.net/defensa_civil/voluntarios.php");
    final response = await http.post(url, body: {
      'nombre': nombreController.text,
      'telefono': telefonoController.text,
      'email': emailController.text,
      'comentarios': comentariosController.text,
    });

    setState(() {
      _cargando = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Formulario enviado con éxito!')));
      // Limpiar los campos después del envío
      nombreController.clear();
      telefonoController.clear();
      emailController.clear();
      comentariosController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al enviar el formulario.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Voluntariado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _cargando
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre Completo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu número de teléfono';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: comentariosController,
                        decoration: InputDecoration(
                          labelText: 'Comentarios',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Enviar el formulario
                            enviarFormulario();
                          }
                        },
                        child: Text('Enviar'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
