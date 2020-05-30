import 'package:flutter/material.dart';
import 'package:newsappflutter/widgets/source_widget.dart';
import '../service/news_api.dart';

class SourcesPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SourcesPage(),
      );
  @override
  _SourcesPageState createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {
  bool _isLoading = false;
  var _sourcesList = new List();

  Future<void> getSources() async {
    NetworkManager networkManager = NetworkManager();
    await networkManager.getSources();
    setState(() {
      _isLoading = false;
      _sourcesList.addAll(networkManager.sources);
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getSources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sources"),
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
                        child: ListView.builder(
                            itemCount: _sourcesList.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SourceWidget(
                                name: _sourcesList[index].name,
                                description: _sourcesList[index].description,
                                url: _sourcesList[index].url,
                                category: _sourcesList[index].category,
                                language: _sourcesList[index].language,
                                country: _sourcesList[index].country,
                                id: _sourcesList[index].id,
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
