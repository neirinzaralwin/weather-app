import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather/weather_event.dart';
import 'package:weather_app/bloc/weather/weather_state.dart';
import 'package:weather_app/database/city_table.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/model/database_model/city_model.dart';
import 'package:weather_app/repository/weather_repo.dart';
import '../../model/forecast_weather_model.dart';
import '../../utils/app_color.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherLoadingState()) {
    on<LoadWeatherEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());
        String query = "";
        if (event.position == "") {
          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          query = "${position.latitude}, ${position.longitude}";
        } else {
          query = event.position!;
        }
        try {
          final CurrentWeatherModel currentWeatherModel = await weatherRepo.getCurrentWeather(query);
          final ForecastWeatherModel forecastWeatherModel = await weatherRepo.getForecastData(query);
          emit(WeatherLoadedState(currentWeatherModel, forecastWeatherModel));
        } catch (e) {
          emit(WeatherErrorState(e.toString()));
        }
      },
    );

    on<SearchWeatherEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());
        try {
          final CurrentWeatherModel currentWeatherModel = await weatherRepo.getCurrentWeather(event.searchQuery);
          final ForecastWeatherModel forecastWeatherModel = await weatherRepo.getForecastData(event.searchQuery);
          emit(WeatherLoadedState(currentWeatherModel, forecastWeatherModel));
        } catch (e) {
          emit(WeatherErrorState(e.toString()));
        }
      },
    );

    on<AddFavouriteCityWeatherEvent>((event, emit) async {
      final CityTable cityTable = CityTable();
      try {
        bool result = await cityTable.insert(CityModel(
          name: event.model.location!.name,
          region: event.model.location!.region,
          country: event.model.location!.country,
          lat: event.model.location!.lat,
          long: event.model.location!.lon,
        ));
        if (result) {
          debugPrint("successfully added");
          BotToast.showText(text: "Added favourite", contentColor: AppColor.primaryColor, textStyle: const TextStyle(color: AppColor.activeIconColorLight));
        } else {
          debugPrint("already added");
          BotToast.showText(
              text: "Already in favourite",
              contentColor: AppColor.activeIconColorDark.withOpacity(0.8),
              textStyle: const TextStyle(color: AppColor.activeIconColorLight));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<LoadCityWeatherEvent>((event, emit) async {
      emit(CityLoadingState());
      final CityTable cityTable = CityTable();
      try {
        List<CityModel> cityList = await cityTable.getAllCities();
        if (cityList.isNotEmpty) {
          List<CityModel> reversedList = [];
          reversedList.addAll(cityList.reversed);
          emit(CityLoadedState(reversedList));
        } else {
          emit(NoCityState());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<DeleteCityWeatherEvent>((event, emit) async {
      emit(CityLoadingState());
      final CityTable cityTable = CityTable();
      try {
        int result = await cityTable.deleteCity(event.name);
        debugPrint(result.toString());
        add(const LoadCityWeatherEvent());
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<ClearAllCitiesEvent>((event, emit) async {
      emit(CityLoadingState());
      final CityTable cityTable = CityTable();
      try {
        await cityTable.deleteAllCities();
        emit(NoCityState());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
