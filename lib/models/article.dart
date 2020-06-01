import 'package:hive/hive.dart';
part 'article.g.dart';

@HiveType()
class Article {
  @HiveField(0)
  String title;
  @HiveField(1)
  String author;
  @HiveField(2)
  String description;
  @HiveField(3)
  String urlToImage;
  @HiveField(4)
  String publishedAt;
  @HiveField(5)
  String content;
  @HiveField(6)
  String url;

  Article(
      {this.title,
      this.description,
      this.author,
      this.content,
      this.publishedAt,
      this.urlToImage,
      this.url});
}
