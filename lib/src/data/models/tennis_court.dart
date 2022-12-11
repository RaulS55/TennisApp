String table = "Tenis";

class TennisFields {
  static final List<String> values = [id, precipprob, name, userName, dateTime];

  static const String id = "id";
  static const String precipprob = "precipprob";
  static const String name = "name";
  static const String userName = "userName";
  static const String dateTime = "dateTime";
}

class TennisCourt {
  final int? id;
  final double precipprob;
  final String name;
  final String userName;
  final DateTime dateTime;

  TennisCourt(
      {this.id,
      required this.precipprob,
      required this.name,
      required this.userName,
      required this.dateTime});

  TennisCourt copy({
    int? id,
  }) =>
      TennisCourt(
          id: id ?? this.id,
          precipprob: precipprob,
          name: name,
          userName: userName,
          dateTime: dateTime);

  static TennisCourt fromJson(Map<String, Object?> json) => TennisCourt(
        id: json[TennisFields.id] as int?,
        precipprob: json[TennisFields.precipprob] as double,
        name: json[TennisFields.name] as String,
        userName: json[TennisFields.userName] as String,
        dateTime: DateTime.parse(json[TennisFields.dateTime] as String),
      );

  Map<String, Object?> toJson() => {
        TennisFields.id: id,
        TennisFields.precipprob: precipprob,
        TennisFields.name: name,
        TennisFields.userName: userName,
        TennisFields.dateTime: dateTime.toIso8601String(),
      };
}
