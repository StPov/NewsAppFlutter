import 'package:http/http.dart' as http;
import 'package:newsappflutter/models/source.dart';
import '../models/article.dart';
import 'dart:convert';

class NetworkManager {
  List<Article> news = [];
  List<Article> sourceDetails = [];
  List<Article> sourceDetailsHeadlines = [];
  List<Source> sources = [];

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
  }

  Future<void> getSources() async {
    const String apiKey = "8c66ce1dfb9245cf9fe9be0a484d713e";
    String url = "https://newsapi.org/v2/sources?apiKey=${apiKey}";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["sources"].forEach((element) {
        if (element['id'] != null) {
          Source source = Source(
            id: element['id'],
            name: element['name'],
            description: element['description'],
            url: element['url'],
            category: element['category'],
            language: element["language"],
            country: element["country"],
          );
          sources.add(source);
        }
      });
    }
  }

  Future<void> getSourceDetails(String id) async {
    const String apiKey = "8c66ce1dfb9245cf9fe9be0a484d713e";
    String url =
        "https://newsapi.org/v2/everything?sources=${id}&apiKey=${apiKey}";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          sourceDetails.add(article);
        }
      });
    }
  }

  Future<void> getSourceDetailsHeadlines(String id) async {
    const String apiKey = "8c66ce1dfb9245cf9fe9be0a484d713e";
    String url =
        "http://newsapi.org/v2/top-headlines?sources=${id}&apiKey=${apiKey}";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          sourceDetailsHeadlines.add(article);
        }
      });
    }
  }
}
