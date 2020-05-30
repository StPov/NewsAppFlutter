import 'package:flutter/material.dart';
import '../pages/article_view_page.dart';
import '../utils/colors.dart';

class NewsWidget extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl;

  NewsWidget(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: postUrl,
                    )));
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                          child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: primaryBlack,
                                  offset: Offset(5.0, 5.0),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text(
                      desc,
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
