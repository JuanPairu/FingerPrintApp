import 'package:fingerprint_app/Models/Usuario.dart';
import 'package:fingerprint_app/Models/data.dart';
import 'package:fingerprint_app/Widgets/cuadrado.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrarHuella extends StatefulWidget {
  const RegistrarHuella({super.key});

  @override
  State<RegistrarHuella> createState() => _RegistrarHuellaState();
}

class _RegistrarHuellaState extends State<RegistrarHuella> {
  final _nombreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Stream<DocumentSnapshot> _documentStream;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _documentStream =
        FirebaseFirestore.instance.collection('Finger').doc('data').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    bool exist = false;
    String id = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Invitado'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo requerido' : null,
                ),
              ),
              const SizedBox(height: 16),
              StreamBuilder<DocumentSnapshot>(
                stream: _documentStream,
                builder: (context, snapshot) {
                  exist = false;
                  id = '';
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Align(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Text('Error al cargar los datos');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Cuadrado(exist: false);
                  }
                  exist = true;
                  final data = Data.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  id = data.id;
                  return Cuadrado(exist: true, id: data.id, fecha: data.creado,);
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: !isLoading ? () async {
                  if (_formKey.currentState!.validate()) {
                    if (!exist || id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Primero registra tu huella'),
                        ),
                      );
                      return;
                    }
                    final usuario = Usuario(
                        nombre: _nombreController.text.trim(),
                        id: id,
                        creado: DateTime.now());

                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseFirestore.instance
                        .collection('Usuarios')
                        .doc(id)
                        .set(usuario.toMap());
                    await FirebaseFirestore.instance
                        .collection('Finger')
                        .doc('data')
                        .delete();
                    _nombreController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al registrar el usuario'),
                        ),
                      );
                      return;
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                }: null,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
