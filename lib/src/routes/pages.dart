import 'package:flutter/widgets.dart';
import 'package:tenis_app/src/routes/routes.dart';
import 'package:tenis_app/src/ui/pages/home/home_page.dart';
import 'package:tenis_app/src/ui/pages/new_reservation/new_reservation.dart';

abstract class Pages {
  // ignore: constant_identifier_names
  static const String INITIAL = Routes.HOME;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.HOME: (_) => const HomePage(),
    Routes.REGISTER: (_) => NewReservationPage(),
  };
}
