import 'package:equatable/equatable.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/model/database_model/city_model.dart';

import '../../model/forecast_weather_model.dart';

abstract class WeatherState extends Equatable {}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final CurrentWeatherModel currentWeatherModel;
  final ForecastWeatherModel forecastWeatherModel;
  WeatherLoadedState(this.currentWeatherModel, this.forecastWeatherModel);

  @override
  List<Object?> get props => [currentWeatherModel, forecastWeatherModel];
}

class WeatherErrorState extends WeatherState {
  final String error;
  WeatherErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CityLoadingState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class CityLoadedState extends WeatherState {
  final List<CityModel> modelList;
  CityLoadedState(this.modelList);
  @override
  List<Object?> get props => [modelList];
}

class NoCityState extends WeatherState {
  @override
  List<Object?> get props => [];
}
