import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/sliding_cards.dart';
import '../service/news_api.dart';

class SourceDetails extends StatefulWidget {
  final String id, name;
  SourceDetails({this.id, this.name});

  @override
  _SourceDetailsState createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  bool _isLoading = false;
  var _sourceDetailsList = new List();

  Future<void> getSourceDetails(String id) async {
    NetworkManager networkManager = NetworkManager();
    await networkManager.getSourceDetails(id);
    setState(() {
      _isLoading = false;
      _sourceDetailsList.addAll(networkManager.sourceDetails);
    });
    print(_sourceDetailsList.length);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getSourceDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text(''),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SlidingCardsView(
                  sourceDetailsList: _sourceDetailsList,
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                        child: Text(
                          "Test App for CDG",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
//          ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}
