import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentations/home/widgets/forecast_weather_widget.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../bloc/weather/weather_state.dart';
import '../../repository/weather_repo.dart';
import 'widgets/current_weather_widget.dart';

class FavouriteDetailPage extends StatefulWidget {
  final String lat;
  final String long;
  const FavouriteDetailPage({super.key, required this.lat, required this.long});

  @override
  State<FavouriteDetailPage> createState() => _FavouriteDetailPageState();
}

class _FavouriteDetailPageState extends State<FavouriteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherBloc(RepositoryProvider.of<WeatherRepository>(context))..add(LoadWeatherEvent(position: "${widget.lat}, ${widget.long}")),
        child: Material(
          child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text("Detail")),
              child: SafeArea(
                child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
                  if (state is WeatherLoadedState) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          CurrentWeatherWidget(model: state.currentWeatherModel),
                          // home > widgets > forecastWeatherWidget.dart
                          ForecastWeatherWidget(model: state.forecastWeatherModel)
                        ],
                      ),
                    );
                  } else if (state is WeatherLoadingState) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return Container();
                }),
              )),
        ));
  }
}
