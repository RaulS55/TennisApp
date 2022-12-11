import 'package:flutter/material.dart';
import 'package:tenis_app/src/ui/util/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onPressed}) : super(key: key);
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return MaterialButton(
      minWidth: double.infinity,
      height: responsive.hp(6),
      color: Colors.green,
      onPressed: onPressed,
      child: const Text(
        "Guardar",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
