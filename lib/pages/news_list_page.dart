import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsapp/components/news_list_tile.dart';
import 'package:newsapp/repository/news_store.dart';
import 'package:newsapp/style/theme.dart';
import '../utils/error_utils.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final NewsStore _newsStore = NewsStore();

  @override
  void initState() {
    super.initState();
    _newsStore.fetchTopHeadlines();
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
      body: Observer(
        builder: (_) {
          if (_newsStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_newsStore.errorMessage != null) {
            return Center(child: Text(_newsStore.errorMessage!));
          }

          return ListView.builder(
            itemCount: _newsStore.articles.length,
            itemBuilder: (context, index) {
              final article = _newsStore.articles[index];
              return NewsTile(
                imageUrl: article.urlToImage ?? '',
                title: article.title,
                date: article.publishedAt ?? 'Date not available',
                imageSize: 100.0,
                author: article.author,
                description: article.description ?? '',
                url: article.url,
              );
            },
          );
        },
      ),
    );
  }
}
