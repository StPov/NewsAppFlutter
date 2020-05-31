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
      _sourceDetailsList = networkManager.sourceDetails;
    });
  }

  Future<void> getSourceDetailsHeadlines(String id) async {
    NetworkManager networkManager = NetworkManager();
    await networkManager.getSourceDetailsHeadlines(id);
    setState(() {
      _isLoading = false;
      _sourceDetailsList = networkManager.sourceDetailsHeadlines;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getSourceDetails(widget.id);
  }

  int groupValue = 0;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text("Everything"),
    1: Text("Headlines")
  };

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
                    CupertinoSegmentedControl(
                      children: logoWidgets,
                      groupValue: groupValue,
                      onValueChanged: (changeFromGroupValue) {
                        setState(() {
                          groupValue = changeFromGroupValue;
                          if (groupValue == 0) {
                            getSourceDetails(widget.id);
                          } else if (groupValue == 1) {
                            getSourceDetailsHeadlines(widget.id);
                          }
                        });
                      },
                    )
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
