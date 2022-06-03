import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_demo/theme/app_color.dart';
import 'Utils/size_utils.dart';
import 'modules/authetication/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimeOut();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(
          "News Application",
          style: TextStyle(color: AppColor.blackColor, fontSize: SizeUtils.horizontalBlockSize * 6, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void startTimeOut() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        Get.offAllNamed(LoginScreen.routeName);
      },
    );
  }
}
