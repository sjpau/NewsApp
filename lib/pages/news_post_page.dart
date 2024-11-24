import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:newsapp/style/theme.dart';

class NewsPostPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String? author;
  final String date;
  final String url;

  const NewsPostPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.date,
    required this.url,
  });

  @override
  _NewsPostPageState createState() => _NewsPostPageState();
}

class _NewsPostPageState extends State<NewsPostPage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //TODO: move to utils
  double _calculateTitleOpacity() {
    const double fadeStart = 100.0;
    const double fadeEnd = 200.0;

    if (_scrollPosition < fadeStart) {
      return 0.0;
    } else if (_scrollPosition > fadeEnd) {
      return 1.0;
    } else {
      return (_scrollPosition - fadeStart) / (fadeEnd - fadeStart);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            flexibleSpace: Container(
              decoration: ThemeStyles.appBarGradientDecoration,
              child: FlexibleSpaceBar(
                title: Opacity(
                  opacity: _calculateTitleOpacity(),
                  child: const Text(
                    "OnBoardingAppMVP",
                    style: ThemeStyles.appBarTitleStyle,
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 72, bottom: 16),
                background: widget.imageUrl.isNotEmpty
                    ? Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 200,
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
            elevation: 0,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description.isNotEmpty
                          ? widget.description
                          : 'No description available.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (widget.author != null &&
                              widget.author!.isNotEmpty)
                            Text(
                              '${widget.author}',
                              style: ThemeStyles.newsTileDateStyle,
                            ),
                          Text(
                            widget.date.isNotEmpty
                                ? DateFormat('yyyy-MMMM-dd HH:mm:ss').format(
                                    DateTime.tryParse(widget.date) ??
                                        DateTime.now())
                                : 'Date not available',
                            style: ThemeStyles.newsTileDateStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await canLaunch(widget.url)) {
                              await launch(widget.url);
                            } else {
                              throw 'Could not launch ${widget.url}';
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 211, 211),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(2)),
                            ),
                          ),
                          child: const Text('READ FULL ARTICLE ONLINE'),
                        ),
                      ),
                    ),
                    Container(
                      // TODO: is there a better way to make it scrollable?
                      height: 500,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
