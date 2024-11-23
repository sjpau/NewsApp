import 'package:flutter/material.dart';
import 'package:newsapp/style/theme.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final double imageSize;

  const NewsTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: ThemeStyles.newsTileMargin,
      child: Card(
        child: Row(
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: ThemeStyles.newsTileImageDecoration.copyWith(
                image: imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
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
                      alignment: Alignment.centerLeft,
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
    );
  }
}
