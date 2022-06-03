import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_demo/splash_screen.dart';
import 'modules/Tabbar/controller/tab_bar_controller.dart';
import 'modules/Tabbar/tabbar_screen.dart';
import 'modules/authentication/controller/authentication_controller.dart';
import 'modules/authentication/screen/login_screen.dart';
import 'modules/homepage/screen/saved_news_screen.dart';
import 'modules/homepage/controller/home_page_controller.dart';
import 'modules/homepage/screen/home_page.dart';
import 'modules/homepage/screen/news_detail_screen.dart';

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
            page: () => const HomePageScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: SavedNewsScreen.routeName,
            page: () => const SavedNewsScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: TabBarScreen.routeName,
            page: () => TabBarScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: DetailedNewsScreen.routeName,
            page: () => DetailedNewsScreen(),
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
