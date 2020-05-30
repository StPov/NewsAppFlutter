import 'package:flutter/material.dart';
import '../widgets/news_widget.dart';
import '../service/news_api.dart';

class NewsPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NewsPage(),
      );

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  var _newsList = new List();
  int _page = 1;

  Future<void> getNews() async {
    NetworkManager news = NetworkManager();
    await news.getNews(_page);
    setState(() {
      _isLoading = false;
      _newsList.addAll(news.news);
      _page++;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getNews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _newsList.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsWidget(
                                imgUrl: _newsList[index].urlToImage ?? "",
                                title: _newsList[index].title ?? "",
                                desc: _newsList[index].description ?? "",
                                content: _newsList[index].content ?? "",
                                postUrl: _newsList[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
