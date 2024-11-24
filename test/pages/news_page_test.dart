import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/pages/news_post_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('NewsPostPage Widget Tests', () {
    testWidgets('should display title, description, author, and date correctly',
        (WidgetTester tester) async {
      const testTitle = 'I want 1 000 000 beers';
      const testDescription = 'This is one of the worlds most descriptions.';
      const testAuthor = 'Travis Barker';
      const testDate = '2032-September-2';
      const testUrl = 'https://blabla.com';
      const testImageUrl = 'https://noimagelolololol';

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: NewsPostPage(
              imageUrl: testImageUrl,
              title: testTitle,
              description: testDescription,
              author: testAuthor,
              date: testDate,
              url: testUrl,
            ),
          ),
        );
      });

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testDescription), findsOneWidget);
      expect(find.text(testAuthor), findsOneWidget);
      final parsedDate = DateTime.parse(testDate);
      final formattedDate =
          DateFormat('yyyy-MMMM-dd HH:mm:ss').format(parsedDate);
      expect(find.text(formattedDate), findsOneWidget);
    });

    testWidgets('should display broken image icon if imageUrl is empty',
        (WidgetTester tester) async {
      const testTitle = 'I want 1 000 000 beers';
      const testDescription = 'This is one of the worlds most descriptions.';
      const testAuthor = 'Travis Barker';
      const testDate = '2032-September-2';
      const testUrl = 'https://blabla.com';
      const testImageUrl = '';

      await tester.pumpWidget(
        const MaterialApp(
          home: NewsPostPage(
            imageUrl: testImageUrl,
            title: testTitle,
            description: testDescription,
            author: testAuthor,
            date: testDate,
            url: testUrl,
          ),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('should open the article URL when button is pressed',
        (WidgetTester tester) async {
      const testTitle = 'I want 1 000 000 beers';
      const testDescription = 'This is one of the worlds most descriptions.';
      const testAuthor = 'Travis Barker';
      const testDate = '2032-September-2';
      const testUrl = 'https://blabla.com';
      const testImageUrl = '';

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: NewsPostPage(
              imageUrl: testImageUrl,
              title: testTitle,
              description: testDescription,
              author: testAuthor,
              date: testDate,
              url: testUrl,
            ),
          ),
        );
      });

      final buttonFinder = find.text('READ FULL ARTICLE ONLINE');
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder);

      await tester.pumpAndSettle();

      expect(buttonFinder, findsOneWidget);
    });
  });
}
