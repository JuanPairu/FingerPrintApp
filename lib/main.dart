import 'package:fingerprint_app/firebase_options.dart';
import 'package:fingerprint_app/lista_invitados.dart';
import 'package:fingerprint_app/regitrar_huella.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finger Print App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: _onRegistrarInvitado,
                  child: const Card(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Registrar Invitado',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Expanded(
                child: GestureDetector(
                  onTap: _onListaDeInvitado,
                  child: const Card(
                    color: Colors.green,
                    child: Center(
                      child: Text('Lista de Invitados',
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onRegistrarInvitado() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegistrarHuella()));
  }

  void _onListaDeInvitado() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ListaDeInvitados()));
  }
}
