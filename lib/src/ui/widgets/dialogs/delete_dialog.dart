import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/src/ui/pages/home/home_controller.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Borrar",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "¿Esta seguro que desea eliminar esta reserva?",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        MaterialButton(
          color: Colors.red.shade100,
          onPressed: () {
            Provider.of<HomeController>(context, listen: false)
                .deleteReservation(id);
            Navigator.pop(context);
          },
          child: const Text("Eliminar"),
        ),
      ],
    );
  }
}
