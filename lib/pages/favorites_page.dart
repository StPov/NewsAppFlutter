import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/news_widget.dart';
import '../service/news_api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoritesPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => FavoritesPage(),
      );

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final articlesBox = Hive.box("articles");

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: articlesBox.length > 0
                      ? ListView.builder(
                          itemCount: articlesBox.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final article = articlesBox.getAt(index);
                            return Slidable(
                              key: ValueKey(index),
                              actionPane: SlidableDrawerActionPane(),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: "Delete",
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  closeOnTap: true,
                                  onTap: () {
                                    Hive.box("articles").deleteAt(index);
                                    setState(() {});
                                  },
                                )
                              ],
                              dismissal: SlidableDismissal(
                                child: SlidableDrawerDismissal(),
                              ),
                              child: NewsWidget(
                                imgUrl: article.urlToImage ?? "",
                                title: article.title ?? "",
                                desc: article.description ?? "",
                                content: article.content ?? "",
                                postUrl: article.url ?? "",
                              ),
                            );
                          })
                      : Center(
                          child: Text('No Articles'),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
