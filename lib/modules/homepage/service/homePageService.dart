import '../../../helpers/network_helper.dart';
import '../../../models/news_data_model.dart';

class HomePageService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<NewsDataModel> getNewsData(String searchText) async {
    try {
      final result = await _networkAPICall.get("everything?q=$searchText&apiKey=a33cdb0605c44914944fc4bfdea2f25f");
      return NewsDataModel.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsDataModel> getAllNewsData() async {
    try {
      final result = await _networkAPICall.get("top-headlines?country=In&apiKey=a33cdb0605c44914944fc4bfdea2f25f");
      return NewsDataModel.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
