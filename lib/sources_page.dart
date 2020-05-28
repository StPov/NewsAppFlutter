import 'package:flutter/material.dart';

class SourcesPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SourcesPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sources"),
      ),
      body: Center(
        child: Text("Sources Screen"),
      ),
    );
  }
}
