class CurrentWeatherModel {
  CurrentWeatherModel({
    this.id,
    required this.location,
    required this.current,
  });
  int? id;
  final Location? location;
  final Current? current;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      id: json['id'],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      current: json["current"] == null ? null : Current.fromJson(json["current"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        "location": location?.toJson(),
        "current": current?.toJson(),
      };
}

class Current {
  Current({
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windMph,
    required this.humidity,
    required this.cloud,
  });

  final double tempC;
  final double tempF;
  final Condition? condition;
  final double windMph;
  final int humidity;
  final int cloud;

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json["temp_c"] ?? 0.0,
      tempF: json["temp_f"] ?? 0.0,
      condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
      windMph: json["wind_mph"] ?? 0.0,
      humidity: json["humidity"] ?? 0,
      cloud: json["cloud"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "temp_f": tempF,
        "condition": condition?.toJson(),
        "wind_mph": windMph,
        "humidity": humidity,
        "cloud": cloud,
      };
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String text;
  final String icon;
  final int code;

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json["text"] ?? "",
      icon: json["icon"] ?? "",
      code: json["code"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Location {
  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
  });

  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"] ?? "",
      region: json["region"] ?? "",
      country: json["country"] ?? "",
      lat: json["lat"] ?? 0.0,
      lon: json["lon"] ?? 0.0,
      tzId: json["tz_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
      };
}
