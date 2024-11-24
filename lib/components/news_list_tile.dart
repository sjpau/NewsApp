import 'package:flutter/material.dart';
import 'package:newsapp/pages/news_post_page.dart';
import 'package:newsapp/style/theme.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final double imageSize;
  final String? author;
  final String description;
  final String url;

  const NewsTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.imageSize,
    required this.author,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsPostPage(
              imageUrl: imageUrl,
              title: title,
              description: description,
              author: author,
              date: date,
              url: url,
            ),
          ),
        );
      },
      child: Container(
        height: 120,
        margin: ThemeStyles.newsTileMargin,
        child: Card(
          child: Row(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: imageUrl.isNotEmpty
                    ? ThemeStyles.newsTileImageDecoration.copyWith(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      )
                    : ThemeStyles.newsTileImageDecoration,
                child: imageUrl.isEmpty
                    ? Icon(Icons.broken_image, size: imageSize / 2)
                    : null,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeStyles.newsTileTitleStyle,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          date,
                          style: ThemeStyles.newsTileDateStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
