import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_model.dart';

import '../../../utils/app_color.dart';
import '../../../utils/screen_util.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeatherModel model;
  const CurrentWeatherWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
