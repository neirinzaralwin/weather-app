import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/screen_util.dart';

import '../../../bloc/weather/weather_bloc.dart';
import '../../../bloc/weather/weather_event.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeatherModel model;
  const CurrentWeatherWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.02, right: screenWidth * 0.1, bottom: screenHeight * 0.03),
      height: screenHeight * 0.3,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondaryColor.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.current!.tempC.toString(),
                          style: TextStyle(color: Colors.black87, fontSize: screenWidth * 0.13),
                        ),
                        Icon(
                          Icons.circle,
                          color: AppColor.primaryColor,
                          size: screenWidth * 0.03,
                        ),
                        Text(
                          "C",
                          style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.1,
                      width: screenWidth * 0.1,
                      child: Image.network(
                        "https:${model.current!.condition!.icon}",
                        width: screenWidth * 0.1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  model.location!.name,
                  style: TextStyle(color: AppColor.secondaryColor, fontSize: screenWidth * 0.05, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  model.location!.country,
                  style: TextStyle(color: AppColor.activeIconColorDark, fontSize: screenWidth * 0.04),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Positioned(
            top: screenWidth * 0.01,
            left: screenWidth * 0.01,
            child: InkWell(
              onTap: () {
                weatherBloc.add(AddFavouriteCityWeatherEvent(model: model));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                constraints: BoxConstraints(maxWidth: screenWidth * 0.25),
                decoration: BoxDecoration(color: AppColor.secondaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Favourite",
                      style: TextStyle(color: AppColor.primaryColor, fontSize: screenWidth * 0.03, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      CupertinoIcons.add,
                      color: AppColor.primaryColor,
                      size: screenWidth * 0.035,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
