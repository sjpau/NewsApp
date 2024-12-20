import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/components/news_list_tile.dart';
import 'package:newsapp/locators/service_locator.dart';
import 'package:newsapp/repository/news_store.dart';
import 'package:newsapp/style/theme.dart';
import '../utils/error_utils.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final NewsStore _newsStore = getIt<NewsStore>();

  @override
  void initState() {
    super.initState();
    _newsStore.fetchTopHeadlines();
  }

  Future<void> _refreshNews() async {
    await _newsStore.fetchTopHeadlines();
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
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
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
      body: Observer(
        builder: (_) {
          if (_newsStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_newsStore.errorMessage != null) {
            return Center(child: Text(_newsStore.errorMessage!));
          }

          return RefreshIndicator(
            onRefresh: _refreshNews,
            child: ListView.builder(
              itemCount: _newsStore.articles.length,
              itemBuilder: (context, index) {
                final article = _newsStore.articles[index];
                late String useDate;
                if (article.publishedAt != null) {
                  var str = article.publishedAt as String;
                  useDate = DateFormat('yyyy-MMMM-dd HH:mm:ss')
                      .format(DateTime.parse(str));
                } else {
                  useDate = 'Date is not available';
                }
                return NewsTile(
                  imageUrl: article.urlToImage ?? '',
                  title: article.title,
                  date: useDate,
                  imageSize: 100.0,
                  author: article.author,
                  description: article.description ?? '',
                  url: article.url,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
