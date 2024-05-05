import 'package:bandasrock/Pantallas/pantalla_listado.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaCreaBandas extends StatefulWidget {
  const PantallaCreaBandas({super.key});

  @override
  _PantallaCreaBandasState createState() => _PantallaCreaBandasState();
}

class _PantallaCreaBandasState extends State<PantallaCreaBandas> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  void _guardarBanda(BuildContext context) async {
      String nombre = nombreController.text;
      String album = albumController.text;
      String year = yearController.text;

      FirebaseFirestore.instance.collection('colecciones').add({
        'NombreBanda': nombre,
        'NombreAlbum': album,
        'AñoLanzamiento': year,
        'CantidadVotos': 0,
      }).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaListadoBandas()),
        );
      }).catchError((error) => print("Error al añadir banda: $error"));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Banda de Rock'),
      ),
      body: Container(
        color: Colors.white, // Color de fondo claro
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nombreController,
                maxLength: 30,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Banda',
                  prefixIcon: Icon(Icons.group_outlined),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: albumController,
                maxLength: 30,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El nombre del Album es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Album',
                  prefixIcon: Icon(Icons.queue_music),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: yearController,
                maxLength: 10,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El Año de Lanzamiento es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Año de Lanzamiento',
                  prefixIcon: Icon(Icons.calendar_month_rounded),
                  border: OutlineInputBorder(),
                ),
              ),

             const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _guardarBanda(context),
                child: const Text('Guardar Banda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
