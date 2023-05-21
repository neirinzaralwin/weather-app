import 'package:equatable/equatable.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/model/database_model/city_model.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class LoadWeatherEvent extends WeatherEvent {
  final String? position;

  const LoadWeatherEvent({this.position = ""});
  @override
  List<Object?> get props => [position];
}

class SearchWeatherEvent extends WeatherEvent {
  final String searchQuery;

  const SearchWeatherEvent({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class AddFavouriteCityWeatherEvent extends WeatherEvent {
  final CurrentWeatherModel model;
  const AddFavouriteCityWeatherEvent({required this.model});
  @override
  List<Object?> get props => [model];
}

class LoadCityWeatherEvent extends WeatherEvent {
  const LoadCityWeatherEvent();
  @override
  List<Object?> get props => [];
}

class DeleteCityWeatherEvent extends WeatherEvent {
  final String name;
  const DeleteCityWeatherEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class ClearAllCitiesEvent extends WeatherEvent {
  const ClearAllCitiesEvent();
  @override
  List<Object?> get props => [];
}
