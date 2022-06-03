import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_demo/modules/homepage/service/homePageService.dart';

import '../../models/NewsDataModel.dart';

class HomePageController extends GetxController {
  RxBool isLoading = false.obs;

  Rx<NewsDataModel> newsDataModel = NewsDataModel().obs;
  final TextEditingController searchController = TextEditingController();

  Future<void> getNewsData(String searchText) async {
    try {
      isLoading.value = true;
      newsDataModel.value = await HomePageService.getNewsData(searchText);
    } catch (e, st) {
      isLoading.value = false;
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllNewsData() async {
    try {
      isLoading.value = true;
      newsDataModel.value = await HomePageService.getAllNewsData();
    } catch (e, st) {
      isLoading.value = false;
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAllNewsData();
    super.onInit();
  }
}
