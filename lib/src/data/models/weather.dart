import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.address,
    required this.days,
  });

  final String address;
  final List<Day> days;

  Weather copyWith({
    String? address,
    List<Day>? days,
  }) =>
      Weather(
        address: address ?? this.address,
        days: days ?? this.days,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        address: json["address"],
        days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
      };
}

class Day {
  Day({
    required this.datetime,
    required this.tempmax,
    required this.tempmin,
    required this.temp,
    required this.precipprob,
    required this.description,
    required this.icon,
  });

  final DateTime datetime;
  final double tempmax;
  final double tempmin;
  final double temp;
  final double precipprob;
  final String description;
  final String icon;

  Day copyWith({
    DateTime? datetime,
    double? tempmax,
    double? tempmin,
    double? temp,
    double? precipprob,
    String? description,
    String? icon,
  }) =>
      Day(
        datetime: datetime ?? this.datetime,
        tempmax: tempmax ?? this.tempmax,
        tempmin: tempmin ?? this.tempmin,
        temp: temp ?? this.temp,
        precipprob: precipprob ?? this.precipprob,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        datetime: DateTime.parse(json["datetime"]),
        tempmax: json["tempmax"].toDouble(),
        tempmin: json["tempmin"].toDouble(),
        temp: json["temp"].toDouble(),
        precipprob: json["precipprob"].toDouble(),
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "datetime":
            "${datetime.year.toString().padLeft(4, '0')}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}",
        "tempmax": tempmax,
        "tempmin": tempmin,
        "temp": temp,
        "precipprob": precipprob,
        "description": description,
        "icon": icon,
      };
}
