import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;

  NewsModel({
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
