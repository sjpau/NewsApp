// news_list_page.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/components/news_list_tile.dart';
import 'package:newsapp/style/theme.dart';
import '../utils/error_utils.dart';
import '../secret.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final String _apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY';
  List<dynamic> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTopHeadlines();
  }

  Future<void> _fetchTopHeadlines() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final dio = Dio();
      final response = await dio.get(_apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          _articles = response.data['articles'];
          _isLoading = false;
        });
      } else {
        showError(context, 'Failed to load news. Please try again later.');
      }
    } catch (e) {
      showError(context, 'An error occurred while fetching the news.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: ThemeStyles.appBarGradientDecoration,
        ),
        title:
            const Text('OnBoarding App', style: ThemeStyles.appBarTitleStyle),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            try {
              Scaffold.of(context).openDrawer();
            } catch (e) {
              showError(
                  context, "NOTE: Drawer requirements weren't specified ;)");
            }
          },
        ),
      ),
      drawer: const Drawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchTopHeadlines,
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  String formattedDate = 'Unknown Date';
                  if (article['publishedAt'] != null) {
                    DateTime parsedDate =
                        DateTime.parse(article['publishedAt']);
                    formattedDate =
                        DateFormat('yyyy-MMMM-dd HH:mm:ss').format(parsedDate);
                  }
                  return NewsTile(
                    imageUrl: article['urlToImage'] ?? '',
                    title: article['title'] ?? 'No Title',
                    date: formattedDate,
                    imageSize: MediaQuery.of(context).size.width / 3,
                  );
                },
              ),
            ),
    );
  }
}
