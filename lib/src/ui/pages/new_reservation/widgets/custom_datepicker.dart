import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/reservation_controller.dart';
import 'package:tenis_app/src/ui/util/global_functions.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key, required this.date}) : super(key: key);
  final Function(DateTime?) date;
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<ReservationController>(context, listen: false);
    return TextField(
        controller: dateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), hintText: "Seleccionar"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            controller.date = pickedDate;
            widget.date(pickedDate);
            dateController.text = formatDate(pickedDate);
          }
        });
  }
}
