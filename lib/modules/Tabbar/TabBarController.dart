import 'package:get/get.dart';
import 'package:news_demo/modules/Tabbar/savedNewsScreen.dart';

import '../homepage/homePage.dart';

class TabBarController extends GetxController {
  RxInt selectItem = 0.obs;
  final page = [
    HomePageScreen(),
    const SavedNewsScreen(),
  ];
}
