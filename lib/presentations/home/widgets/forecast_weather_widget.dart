import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/screen_util.dart';

import '../../../model/forecast_weather_model.dart';
import '../../../utils/constants.dart';

class ForecastWeatherWidget extends StatelessWidget {
  final ForecastWeatherModel model;
  const ForecastWeatherWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: AppColor.disableIconColorDark,
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                "7 days forecast",
                style: TextStyle(
                  color: AppColor.disableIconColorDark,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.04,
                ),
              )
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.forecast!.forecastday!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getDayText(DateFormat('yyyy-MM-dd').format(model.forecast!.forecastday![index].date!), index),
                        style: TextStyle(color: AppColor.activeIconColorDark, fontSize: screenWidth * 0.03),
                      ),
                      SizedBox(
                        width: screenWidth * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              "https:${model.forecast!.forecastday![index].day!.condition!.icon!}",
                              fit: BoxFit.cover,
                              width: screenWidth * 0.08,
                            ),
                            _tempText("Lowest", model.forecast!.forecastday![index].day!.mintempC, screenWidth, AppColor.secondaryColor),
                            _tempText("Highest", model.forecast!.forecastday![index].day!.maxtempC, screenWidth, AppColor.primaryColor),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _tempText(String text, double degree, double screenWidth, Color color) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(color: AppColor.activeIconColorDark, fontWeight: FontWeight.w300, fontSize: screenWidth * 0.025),
        ),
        Text(
          degree.floor().toString() + degreeSymbol,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035),
        ),
      ],
    );
  }

  String _getDayText(String data, int index) {
    String current = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String yesterday = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));

    if (current == data) {
      return "Today";
    } else if (data == yesterday) {
      return "Yesterday";
    }
    return DateFormat.EEEE().format(model.forecast!.forecastday![index].date!);
  }
}
