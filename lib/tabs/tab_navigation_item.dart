import 'package:flutter/material.dart';
import '../sources_page.dart';
import '../favorites_page.dart';
import '../news_page.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: SourcesPage(),
          icon: Icon(Icons.import_contacts),
          title: Text("Sources"),
        ),
        TabNavigationItem(
          page: NewsPage(),
          icon: Icon(Icons.library_books),
          title: Text("News"),
        ),
        TabNavigationItem(
          page: FavoritesPage(),
          icon: Icon(Icons.bookmark),
          title: Text("Favorites"),
        ),
      ];
}
