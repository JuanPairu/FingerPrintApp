import 'package:fingerprint_app/Models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ListaDeInvitados extends StatefulWidget {
  const ListaDeInvitados({super.key});

  @override
  State<ListaDeInvitados> createState() => _ListaDeInvitadosState();
}

class _ListaDeInvitadosState extends State<ListaDeInvitados> {
  late final Stream<QuerySnapshot> _usuariosStream;

  @override
  void initState() {
    super.initState();
    _usuariosStream =
        FirebaseFirestore.instance.collection('Usuarios').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Invitados'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usuariosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay invitados registrados'));
          }

          final usuarios = snapshot.data!.docs.map((doc) {
            return Usuario.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(usuario.nombre),
                    subtitle: usuario.ingreso != null
                        ? Text('Ingreso: ${formatter.format(usuario.ingreso!)}')
                        : null,
                    trailing: CircleAvatar(
                      maxRadius: 8,
                      backgroundColor:
                          usuario.ingreso != null ? Colors.green : Colors.red,
                    ),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: onEliminar, child: Text('Eliminar Todos los Invitados')),
              )
            ],
          );
        },
      ),
    );
  }
  void onEliminar(){
    FirebaseFirestore.instance.collection('Usuarios').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }
}
