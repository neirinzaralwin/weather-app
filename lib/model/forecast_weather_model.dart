// To parse this JSON data, do
//
//     final forecastWeatherModel = forecastWeatherModelFromJson(jsonString);

import 'dart:convert';

ForecastWeatherModel forecastWeatherModelFromJson(String str) => ForecastWeatherModel.fromJson(json.decode(str));

String forecastWeatherModelToJson(ForecastWeatherModel data) => json.encode(data.toJson());

class ForecastWeatherModel {
  Forecast? forecast;

  ForecastWeatherModel({
    this.forecast,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) => ForecastWeatherModel(
        forecast: json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]),
      );

  Map<String, dynamic> toJson() => {
        "forecast": forecast?.toJson(),
      };
}

class Condition {
  String? text;
  String? icon;
  dynamic code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: json["forecastday"] == null ? [] : List<Forecastday>.from(json["forecastday"]!.map((x) => Forecastday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forecastday": forecastday == null ? [] : List<dynamic>.from(forecastday!.map((x) => x.toJson())),
      };
}

class Forecastday {
  DateTime? date;
  dynamic dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: json["day"] == null ? null : Day.fromJson(json["day"]),
        astro: json["astro"] == null ? null : Astro.fromJson(json["astro"]),
        hour: json["hour"] == null ? [] : List<Hour>.from(json["hour"]!.map((x) => Hour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "date_epoch": dateEpoch,
        "day": day?.toJson(),
        "astro": astro?.toJson(),
        "hour": hour == null ? [] : List<dynamic>.from(hour!.map((x) => x.toJson())),
      };
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;
  dynamic isMoonUp;
  dynamic isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        moonIllumination: json["moon_illumination"],
        isMoonUp: json["is_moon_up"],
        isSunUp: json["is_sun_up"],
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "moon_illumination": moonIllumination,
        "is_moon_up": isMoonUp,
        "is_sun_up": isSunUp,
      };
}

class Day {
  dynamic maxtempC;
  dynamic maxtempF;
  dynamic mintempC;
  dynamic mintempF;
  dynamic avgtempC;
  dynamic avgtempF;
  dynamic maxwindMph;
  dynamic maxwindKph;
  dynamic totalprecipMm;
  dynamic totalprecipIn;
  dynamic totalsnowCm;
  dynamic avgvisKm;
  dynamic avgvisMiles;
  dynamic avghumidity;
  dynamic dailyWillItRain;
  dynamic dailyChanceOfRain;
  dynamic dailyWillItSnow;
  dynamic dailyChanceOfSnow;
  Condition? condition;
  dynamic uv;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"]?.toDouble(),
        maxtempF: json["maxtemp_f"]?.toDouble(),
        mintempC: json["mintemp_c"]?.toDouble(),
        mintempF: json["mintemp_f"]?.toDouble(),
        avgtempC: json["avgtemp_c"]?.toDouble(),
        avgtempF: json["avgtemp_f"]?.toDouble(),
        maxwindMph: json["maxwind_mph"]?.toDouble(),
        maxwindKph: json["maxwind_kph"]?.toDouble(),
        totalprecipMm: json["totalprecip_mm"]?.toDouble(),
        totalprecipIn: json["totalprecip_in"]?.toDouble(),
        totalsnowCm: json["totalsnow_cm"],
        avgvisKm: json["avgvis_km"]?.toDouble(),
        avgvisMiles: json["avgvis_miles"],
        avghumidity: json["avghumidity"],
        dailyWillItRain: json["daily_will_it_rain"],
        dailyChanceOfRain: json["daily_chance_of_rain"],
        dailyWillItSnow: json["daily_will_it_snow"],
        dailyChanceOfSnow: json["daily_chance_of_snow"],
        condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
        uv: json["uv"],
      );

  Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "maxtemp_f": maxtempF,
        "mintemp_c": mintempC,
        "mintemp_f": mintempF,
        "avgtemp_c": avgtempC,
        "avgtemp_f": avgtempF,
        "maxwind_mph": maxwindMph,
        "maxwind_kph": maxwindKph,
        "totalprecip_mm": totalprecipMm,
        "totalprecip_in": totalprecipIn,
        "totalsnow_cm": totalsnowCm,
        "avgvis_km": avgvisKm,
        "avgvis_miles": avgvisMiles,
        "avghumidity": avghumidity,
        "daily_will_it_rain": dailyWillItRain,
        "daily_chance_of_rain": dailyChanceOfRain,
        "daily_will_it_snow": dailyWillItSnow,
        "daily_chance_of_snow": dailyChanceOfSnow,
        "condition": condition?.toJson(),
        "uv": uv,
      };
}

class Hour {
  dynamic timeEpoch;
  String? time;
  dynamic tempC;
  dynamic tempF;
  dynamic isDay;
  Condition? condition;
  dynamic windMph;
  dynamic windKph;
  dynamic windDegree;
  String? windDir;
  dynamic pressureMb;
  dynamic pressureIn;
  dynamic precipMm;
  dynamic precipIn;
  dynamic humidity;
  dynamic cloud;
  dynamic feelslikeC;
  dynamic feelslikeF;
  dynamic windchillC;
  dynamic windchillF;
  dynamic heatindexC;
  dynamic heatindexF;
  dynamic dewpointC;
  dynamic dewpointF;
  dynamic willItRain;
  dynamic chanceOfRain;
  dynamic willItSnow;
  dynamic chanceOfSnow;
  dynamic visKm;
  dynamic visMiles;
  dynamic gustMph;
  dynamic gustKph;
  dynamic uv;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json["time_epoch"],
        time: json["time"],
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"]?.toDouble(),
        isDay: json["is_day"],
        condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"]?.toDouble(),
        windKph: json["wind_kph"]?.toDouble(),
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"]?.toDouble(),
        precipMm: json["precip_mm"],
        precipIn: json["precip_in"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        feelslikeF: json["feelslike_f"]?.toDouble(),
        windchillC: json["windchill_c"]?.toDouble(),
        windchillF: json["windchill_f"]?.toDouble(),
        heatindexC: json["heatindex_c"]?.toDouble(),
        heatindexF: json["heatindex_f"]?.toDouble(),
        dewpointC: json["dewpoint_c"]?.toDouble(),
        dewpointF: json["dewpoint_f"]?.toDouble(),
        willItRain: json["will_it_rain"],
        chanceOfRain: json["chance_of_rain"],
        willItSnow: json["will_it_snow"],
        chanceOfSnow: json["chance_of_snow"],
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        gustMph: json["gust_mph"]?.toDouble(),
        gustKph: json["gust_kph"]?.toDouble(),
        uv: json["uv"],
      );

  Map<String, dynamic> toJson() => {
        "time_epoch": timeEpoch,
        "time": time,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition?.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "windchill_c": windchillC,
        "windchill_f": windchillF,
        "heatindex_c": heatindexC,
        "heatindex_f": heatindexF,
        "dewpoint_c": dewpointC,
        "dewpoint_f": dewpointF,
        "will_it_rain": willItRain,
        "chance_of_rain": chanceOfRain,
        "will_it_snow": willItSnow,
        "chance_of_snow": chanceOfSnow,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
        "uv": uv,
      };
}
