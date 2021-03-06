import 'package:get/get.dart';
import 'package:news_demo/modules/homepage/screen/saved_news_screen.dart';

import '../../homepage/screen/home_page.dart';

class TabBarController extends GetxController {
  RxInt selectItem = 0.obs;
  final page = [
    const HomePageScreen(),
    const SavedNewsScreen(),
  ];
}
