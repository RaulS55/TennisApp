import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.name, required this.day})
      : super(key: key);
  final String name;
  final String day;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Error",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Actualmente no quedan lugares disponibles para la $name en el dia $day",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
