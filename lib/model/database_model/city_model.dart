import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? long;

  CityModel({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.long,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "long": long,
      };
}
