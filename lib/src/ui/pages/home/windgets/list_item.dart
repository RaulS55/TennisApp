import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tenis_app/src/data/models/tennis_court.dart';
import 'package:tenis_app/src/ui/widgets/dialogs/delete_dialog.dart';
import 'package:tenis_app/src/ui/util/global_functions.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.tennisCourt,
  }) : super(key: key);
  final TennisCourt tennisCourt;
  @override
  Widget build(BuildContext context) {
    Color getColor(text) {
      switch (text) {
        case "Cancha A":
          return Colors.green;
        case "Cancha B":
          return Colors.red;
        case "Cancha C":
          return Colors.blue;

        default:
          return Colors.green;
      }
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: getColor(tennisCourt.name),
        child: Text(
          tennisCourt.name
              .substring(tennisCourt.name.length - 1, tennisCourt.name.length),
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tennisCourt.userName),
          Text(formatDate(tennisCourt.dateTime)),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tennisCourt.name),
          Text("Precipitacion: ${tennisCourt.precipprob}%"),
        ],
      ),
      trailing: CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          child: const Icon(Ionicons.trash, color: Colors.red),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => DeleteDialog(id: tennisCourt.id!))),
    );
  }
}
