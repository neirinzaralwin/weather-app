import 'dart:convert';
import 'package:http/http.dart';
import '../model/forecast_weather_model.dart';
import '../utils/constants.dart';
import '../model/current_weather_model.dart';

class WeatherRepository {
  // current
  String currentWeatherURL = "$BASE_URL/current.json?key=$WEATHER_API_KEY&q=";

  Future<CurrentWeatherModel> getCurrentWeather(var query) async {
    Response response = await get(Uri.parse(currentWeatherURL + query));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return CurrentWeatherModel.fromJson(json);
    } else {
      var json = jsonDecode(response.body);
      throw json["error"]["message"];
    }
  }

  // forecast next7 days
  String forecastWeatherURL = "$BASE_URL/forecast.json?key=$WEATHER_API_KEY&q=";

  Future<ForecastWeatherModel> getForecastData(var query) async {
    Response response = await get(Uri.parse("${forecastWeatherURL + query}&days=7&hour=6"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ForecastWeatherModel.fromJson(json);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
