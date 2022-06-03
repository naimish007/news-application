import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:news_demo/models/news_data_model.dart';

class AppSharedPreference {
  static final _getStorage = GetStorage();

  static const _userName = 'user_name';
  static const _saveArticles = 'save_articles';

  static Future<void> setUserName(String userName) async {
    return _getStorage.write(_userName, userName);
  }

  static String? get userName {
    return _getStorage.read(_userName);
  }

  static saveArticles(Articles articles) async {
    NewsDataModel saveNewsDataModel = await getArticles();
    print("saveArticles articles: ${articles.toJson()}");
    saveNewsDataModel.articles!.add(articles);
    log("saveArticles saveNewsDataModel: ${saveNewsDataModel.toJson()}");
    await _getStorage.write(_saveArticles, json.encode(saveNewsDataModel.toJson()));
  }

  static Future<NewsDataModel> getArticles() async {
    NewsDataModel? newsDataModel;
    String? articlesListString = _getStorage.read(_saveArticles);
    print("getArticles articlesListString: ${articlesListString}");
    if (articlesListString != null) {
      newsDataModel = NewsDataModel.fromJson(json.decode(articlesListString));
    }
    print("getArticles newsDataModel: ${newsDataModel?.toJson()}");

    return newsDataModel ?? NewsDataModel(articles: []);
  }

  static Future<void> clear() async => _getStorage.erase();

  static Future<void> removeAndSaveArticles(List<Articles> articlesList) async {
    _getStorage.remove(_saveArticles);
    NewsDataModel newsDataModel = NewsDataModel(articles: articlesList);
    log("removeAndSaveArticles saveNewsDataModel: ${newsDataModel.toJson()}");
    await _getStorage.write(_saveArticles, json.encode(newsDataModel.toJson()));
  }
}
