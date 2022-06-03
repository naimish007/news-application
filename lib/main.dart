import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_demo/splash_screen.dart';
import 'modules/Tabbar/tab_bar_controller.dart';
import 'modules/Tabbar/tabbar_screen.dart';
import 'modules/Tabbar/saved_news_screen.dart';
import 'modules/authetication/controller/authentication_controller.dart';
import 'modules/authetication/login_screen.dart';
import 'modules/homepage/home_page_controller.dart';
import 'modules/homepage/home_page.dart';

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
            page: () => SplashScreen(),
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
