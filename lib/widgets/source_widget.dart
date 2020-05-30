import 'package:flutter/material.dart';
import 'package:newsappflutter/pages/source_details_page.dart';
import '../pages/article_view_page.dart';
import '../utils/colors.dart';

class SourceWidget extends StatelessWidget {
  final String name, description, url, category, language, country, id;

  SourceWidget(
      {this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country,
      this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SourceDetails(id: id, name: name)));
      },
      child: Container(
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
                      ClipRRect(child: Image.asset('assets/images/news4.jpg')),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: primaryBlack,
                                      offset: Offset(5.0, 5.0),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              description,
                              maxLines: 7,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: primaryBlack,
                                      offset: Offset(5.0, 5.0),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
