import 'package:flutter/cupertino.dart';
import 'package:tenis_app/src/data/controllers/weather_api.dart';
import 'package:tenis_app/src/data/models/weather.dart';
import 'package:tenis_app/src/ui/util/global_functions.dart';
import 'package:tenis_app/src/ui/widgets/loading/custom_loading_controller.dart';

class ReservationController extends ChangeNotifier {
  late DateTime _date;
  Weather? weather;
  DateTime get date => _date;
  double get precipprob => weather!.days[0].precipprob;
  set date(DateTime value) {
    LoadingWidgetController.instance.loading();
    _date = value;
    _setWeather();
  }

  _setWeather() async {
    weather = await WeatherApi().getWeather(formatDateApi(_date));
    LoadingWidgetController.instance.close();
    notifyListeners();
  }
}
