import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_demo/splashScreen.dart';
import 'modules/Tabbar/TabBarController.dart';
import 'modules/Tabbar/TabbarScreen.dart';
import 'modules/Tabbar/savedNewsScreen.dart';
import 'modules/authetication/controller/authenticationController.dart';
import 'modules/authetication/loginScreen.dart';
import 'modules/homepage/HomePageController.dart';
import 'modules/homepage/homePage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News World',
        initialBinding: AppBidding(),
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        getPages: [
          GetPage(
            name: SplashScreen.routeName,
            page: () => const SplashScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: LoginScreen.routeName,
            page: () => LoginScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: HomePageScreen.routeName,
            page: () => HomePageScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: SavedNewsScreen.routeName,
            page: () => SavedNewsScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: TabBarScreen.routeName,
            page: () => TabBarScreen(),
            transition: Transition.rightToLeft,
          ),
        ]);
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(HomePageController());
    Get.put(TabBarController());
  }
}
