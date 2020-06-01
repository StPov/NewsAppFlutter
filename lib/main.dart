import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsappflutter/models/article.dart';
import 'tabs/tabs_page.dart';
import 'utils/colors.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ArticleAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
//    Hive.box("articles").compact();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: primaryBlack,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox("articles"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return TabsPage();
            }
            // Although opening a Box takes a very short time,
            // we still need to return something before the Future completes.
            else
              return Scaffold();
          },
        ));
  }
}
