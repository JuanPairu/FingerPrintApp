import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Cuadrado extends StatelessWidget {
  const Cuadrado({super.key, required this.exist, this.id, this.fecha});
  final bool exist;
  final String? id;
  final DateTime? fecha;
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');

    return Container(
      // width: 100,
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: exist ? Colors.green : Colors.red,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              exist ? Icons.done : Icons.clear,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              exist ? 'Huella Encontrada: $id' : 'Registrar Huella',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          if(fecha != null)
            Text(
              formatter.format(fecha!),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
