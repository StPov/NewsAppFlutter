import 'package:http/http.dart' as http;
import './article.dart';
import 'dart:convert';

class News {
  List<Article> news = [];

  Future<void> getNews(int page) async {
    const String apiKey = "8c66ce1dfb9245cf9fe9be0a484d713e";
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&page=${page}&apiKey=${apiKey}";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
    print(url);
    print(news.length);
    print(page);
  }
}
