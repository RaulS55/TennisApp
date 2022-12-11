import 'package:flutter/material.dart';

class ComboBox extends StatefulWidget {
  const ComboBox({Key? key, required this.list, required this.onChanged})
      : super(key: key);
  final List<String> list;
  final Function(String?) onChanged;

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  late String val;
  @override
  void initState() {
    val = widget.list[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        ),
        isExpanded: true,
        elevation: 0,
        value: val,
        items: _listToComboBox(widget.list),
        onChanged: (value) {
          val = value!;
          widget.onChanged(value);
          setState(() {});
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _listToComboBox(List<String> list) {
    return list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
