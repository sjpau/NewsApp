import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/repository/models/news_model.dart';
import '../secret.dart';

part 'news_store.g.dart';

class NewsStore = _NewsStore with _$NewsStore;

abstract class _NewsStore with Store {
  final String _apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY';

  @observable
  ObservableList<NewsModel> articles = ObservableList<NewsModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  final Dio _dio = Dio();

  @action
  Future<void> fetchTopHeadlines() async {
    isLoading = true;
    errorMessage = null;
    try {
      final response = await _dio.get(_apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> articlesJson = response.data['articles'];
        final fetchedArticles = (articlesJson as List)
            .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
            .toList();
        articles = ObservableList<NewsModel>.of(fetchedArticles);
      } else {
        errorMessage = 'Failed to load news. Please try again later.';
      }
    } catch (e) {
      errorMessage = 'An error occurred while fetching the news: $e';
    } finally {
      isLoading = false;
    }
  }
}
