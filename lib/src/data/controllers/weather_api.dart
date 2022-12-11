import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tenis_app/src/data/constants/data.dart';
import 'package:tenis_app/src/data/models/weather.dart';
import 'package:tenis_app/src/data/services/internet_service.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static final WeatherApi _weatherApi = WeatherApi._internal();

  factory WeatherApi() => _weatherApi;

  WeatherApi._internal();

  Future<Weather?> getWeather(String date) async {
    try {
      if (await InternetServices.instance.connected()) {
        var url = Uri.parse(
            "${Constants.URL_REST}VisualCrossingWebServices/rest/services/timeline/argentina/${date}T13:00:00?key=WFBAYEJL82J9KYQQ29FDQJ9UN");

        late Map data;
        var response = await http.get(url);
        data = jsonDecode(response.body);
        return Weather.fromJson(data as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR $e");
      }
      return null;
    }
    return null;
  }
}
