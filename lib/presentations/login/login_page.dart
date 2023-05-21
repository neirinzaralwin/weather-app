import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/app/app_bloc.dart';
import 'package:weather_app/bloc/app/app_event.dart';
import 'package:weather_app/bloc/app/app_state.dart';
import 'package:weather_app/presentations/home/home_page.dart';
import 'package:weather_app/repository/app_repo.dart';
import 'package:weather_app/utils/app_color.dart';

import '../../utils/screen_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil.getScreenWidth(context);
    double screenHeight = ScreenUtil.getScreenHeight(context);

    return BlocProvider(
      create: (context) => AppBloc(RepositoryProvider.of<AppRepository>(context))..add(LoadAppEvent()),
      child: Material(
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text("Login"),
          ),
          child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state is AppLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is AppLoadedState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hint:",
                        style: TextStyle(color: AppColor.disableIconColorDark, fontSize: screenWidth * 0.038, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Copy token and paste at admin dashboard to send notification to this app.",
                      style: TextStyle(color: AppColor.disableIconColorDark, fontSize: screenWidth * 0.035),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    _buildFCMTokenWidget(state, screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.05),
                    CupertinoButton(
                        color: AppColor.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(color: AppColor.activeIconColorLight, fontWeight: FontWeight.w500, fontSize: screenWidth * 0.04),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Icon(
                              CupertinoIcons.arrow_right_circle,
                              size: screenWidth * 0.04,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        }),
                  ],
                ),
              );
            }

            return Container();
          }),
        ),
      ),
    );
  }

  Widget _buildFCMTokenWidget(AppLoadedState state, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColor.primaryColorLight,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: state.fcmtoken)).then((value) {
                      BotToast.showText(
                          text: "Copied to clipboard", contentColor: AppColor.primaryColor, textStyle: const TextStyle(color: AppColor.activeIconColorLight));
                    });
                  },
                  icon: Icon(
                    Icons.copy,
                    size: screenWidth * 0.05,
                  )),
              Text(
                "Copy",
                style: TextStyle(color: AppColor.primaryColor, fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            state.fcmtoken,
            style: TextStyle(color: AppColor.primaryColor, fontSize: screenWidth * 0.035),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
