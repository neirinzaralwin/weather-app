import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/bloc/weather/weather_event.dart';
import 'package:weather_app/bloc/weather/weather_state.dart';
import 'package:weather_app/presentations/favourite/favourite_page.dart';
import 'package:weather_app/repository/weather_repo.dart';

import '../../utils/app_color.dart';
import '../../utils/screen_util.dart';
import 'widgets/current_weather_widget.dart';
import 'widgets/forecast_weather_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);

    return BlocProvider(
      create: (context) => WeatherBloc(RepositoryProvider.of<WeatherRepository>(context))..add(LoadWeatherEvent()),
      child: Material(
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Home"),
              trailing: CupertinoButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritePage())),
                child: Icon(
                  CupertinoIcons.heart,
                  color: AppColor.primaryColor,
                  size: screenWidth * 0.05,
                ),
              ),
            ),
            child: SafeArea(
              child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(const Duration(milliseconds: 1000), () {
                            if (searchQuery != value) {
                              setState(() {
                                searchQuery = value;
                              });
                              if (searchQuery.isNotEmpty) {
                                debugPrint("searching");
                                final weatherBloc = BlocProvider.of<WeatherBloc>(context);
                                weatherBloc.add(SearchWeatherEvent(searchQuery: searchQuery));
                              }
                            }
                          });
                        },
                        style: TextStyle(color: AppColor.secondaryColor, fontSize: screenWidth * 0.04),
                        cursorColor: AppColor.secondaryColor,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.secondaryColor.withOpacity(0.2),
                            contentPadding: const EdgeInsets.all(0),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColor.primaryColor,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  if (searchController.text.isNotEmpty || searchQuery.isNotEmpty) {
                                    setState(() {
                                      searchQuery = "";
                                    });
                                    searchController.clear();
                                    debugPrint("location reset");
                                    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
                                    weatherBloc.add(const LoadWeatherEvent());
                                  }
                                },
                                child: const Icon(Icons.cancel_outlined, color: AppColor.primaryColor)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                            hintStyle: TextStyle(color: AppColor.secondaryColor, fontSize: screenWidth * 0.04),
                            hintText: "Search city"),
                      ),
                    ),
                    _buildHome(state, screenWidth, screenHeight, context)
                  ],
                );
              }),
            )),
      ),
    );
  }

  Widget _buildHome(WeatherState state, double screenWidth, double screenHeight, BuildContext context) {
    if (state is WeatherLoadingState) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (state is WeatherLoadedState) {
      return SingleChildScrollView(
        child: Column(
          children: [
            CurrentWeatherWidget(model: state.currentWeatherModel),
            ForecastWeatherWidget(model: state.forecastWeatherModel),
          ],
        ),
      );
    } else if (state is WeatherErrorState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.error,
            style: const TextStyle(color: Colors.red),
          ),
          InkWell(
            onTap: () {
              final weatherBloc = BlocProvider.of<WeatherBloc>(context);
              if (searchController.text.isNotEmpty) {
                debugPrint("searching again");
                weatherBloc.add(SearchWeatherEvent(searchQuery: searchQuery));
              } else {
                weatherBloc.add(LoadWeatherEvent());
              }
            },
            child: SizedBox(
              height: screenHeight * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tap to retry",
                    style: TextStyle(color: AppColor.primaryColor, fontSize: screenWidth * 0.035),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Icon(Icons.touch_app_outlined, color: AppColor.primaryColor, size: screenWidth * 0.045)
                ],
              ),
            ),
          )
        ],
      );
    }

    return Container();
  }
}
