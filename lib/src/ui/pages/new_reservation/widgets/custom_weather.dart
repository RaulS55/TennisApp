import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tenis_app/src/ui/util/responsive.dart';

class CustomWeather extends StatelessWidget {
  const CustomWeather({Key? key, required this.weather}) : super(key: key);
  final double weather;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return SizedBox(
      height: responsive.hp(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Ionicons.rainy_outline, size: responsive.dp(3)),
          const SizedBox(width: 10),
          Text(
            "$weather%",
            style: TextStyle(fontSize: responsive.dp(2.5)),
          ),
        ],
      ),
    );
  }
}
