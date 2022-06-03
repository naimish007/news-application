import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_demo/helpers/shared_preference.dart';
import 'package:news_demo/modules/homepage/service/homePageService.dart';

import '../../models/news_data_model.dart';

class HomePageController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingSecond = false.obs;

  Rx<Articles> articleData =Articles().obs;
  Rx<NewsDataModel> newsDataModel = NewsDataModel().obs;
  Rx<NewsDataModel> saveNewsDataModel = NewsDataModel().obs;

  final TextEditingController searchController = TextEditingController();

  RxList<NewsDataModel> newsListPagination = <NewsDataModel>[].obs;
  int startIndex = 0;
  int endIndex = 15;
  int pageLimit = 15;

  Future<void> getNewsData(String searchText) async {
    try {
      isLoading.value = true;
      newsDataModel.value = await HomePageService.getNewsData(searchText);
      for (var element in saveNewsDataModel.value.articles!) {
        int index = newsDataModel.value.articles!
            .indexWhere((elementInner) => elementInner.url == element.url);
        if (index != -1) {
          newsDataModel.value.articles![index].isLike = true;
        }
      }
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
      startIndex = 1 + newsListPagination.length;
      endIndex = pageLimit + startIndex;
      newsDataModel.value = await HomePageService.getAllNewsData();
      for (startIndex; startIndex <= endIndex; startIndex++) {
        newsListPagination.add(newsDataModel.value);
      }

      print("newsListPagination==>>>${newsListPagination.length}");
      for (var element in saveNewsDataModel.value.articles!) {
        int index = newsDataModel.value.articles!
            .indexWhere((elementInner) => elementInner.url == element.url);
        if (index != -1) {
          newsDataModel.value.articles![index].isLike = true;
        }
      }
    } catch (e, st) {
      isLoading.value = false;
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setLike(Articles articles) async {
    await AppSharedPreference.saveArticles(articles);
  }

  void getSaveArticlesList() async {
    try {
      isLoadingSecond.value = true;
      saveNewsDataModel.value = await AppSharedPreference.getArticles();
    } catch (e, st) {
      isLoadingSecond.value = false;
      log("Error Message: $e : $st");
    } finally {
      isLoadingSecond.value = false;
    }
  }

  Future<void> unLikeAndSave(List<Articles> articlesList) async {
    await AppSharedPreference.removeAndSaveArticles(articlesList);
  }

  @override
  void onInit() {
    getAllNewsData();
    super.onInit();
  }
}
