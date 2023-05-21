import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/database_model/city_model.dart';
import 'package:weather_app/presentations/favourite/favourite_detail_page.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimension_manager.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../bloc/weather/weather_state.dart';
import '../../repository/weather_repo.dart';
import '../../utils/screen_util.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);

    return BlocProvider(
      create: (context) => WeatherBloc(RepositoryProvider.of<WeatherRepository>(context))..add(const LoadCityWeatherEvent()),
      child: Material(
          child: CupertinoPageScaffold(
        child: SafeArea(
            child: CustomScrollView(
          slivers: <Widget>[
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              return CupertinoSliverNavigationBar(
                largeTitle: const Text('Favourites'),
                trailing: CupertinoButton(
                  child: Icon(
                    CupertinoIcons.delete,
                    color: AppColor.redColor,
                    size: DimensionManager.font14,
                  ),
                  onPressed: () {
                    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
                    weatherBloc.add(const ClearAllCitiesEvent());
                  },
                ),
              );
            }),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is CityLoadedState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? screenWidth * 0.02 : 0.0),
                          child: buildCityWidget(model: state.modelList[index], screenWidth: screenWidth, screenHeight: screenHeight, context: context),
                        );
                      },
                      childCount: state.modelList.length, // 1000 list items
                    ),
                  );
                } else if (state is NoCityState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.35),
                          child: Center(
                            child: Text(
                              "Empty",
                              style: TextStyle(fontSize: DimensionManager.font12, color: AppColor.secondaryColor),
                            ),
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container();
                    },
                    childCount: 1,
                  ),
                );
              },
            ),
          ],
        )),
      )),
    );
  }

  Widget buildCityWidget({required CityModel model, required double screenWidth, required double screenHeight, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FavouriteDetailPage(
                      lat: model.lat.toString(),
                      long: model.long.toString(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryColor.withOpacity(0.3),
              spreadRadius: 8,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: screenWidth * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  style: TextStyle(color: AppColor.activeIconColorLight, fontSize: screenWidth * 0.05, fontWeight: FontWeight.w200),
                  maxLines: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View detail",
                      style: TextStyle(color: AppColor.primaryColorLight, fontSize: screenWidth * 0.03),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Icon(CupertinoIcons.arrow_right_circle, color: AppColor.primaryColorLight, size: screenWidth * 0.03)
                  ],
                )
              ],
            ),
          ),
          CupertinoButton(
              child: Text(
                "Remove",
                style: TextStyle(color: AppColor.primaryColorLight, fontSize: screenWidth * 0.035),
              ),
              onPressed: () {
                final weatherBloc = BlocProvider.of<WeatherBloc>(context);
                weatherBloc.add(DeleteCityWeatherEvent(model.name!));
              })
        ]),
      ),
    );
  }
}
