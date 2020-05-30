import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import '../utils/colors.dart';

// ignore: must_be_immutable
class SlidingCardsView extends StatefulWidget {
  var sourceDetailsList = new List();
  SlidingCardsView({this.sourceDetailsList});

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: PageView(
        controller: pageController,
        children: [
          for (var i in widget.sourceDetailsList)
            SlidingCard(
              title: i.title,
              description: i.description,
              assetName: i.urlToImage,
              offset: pageOffset,
            )
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String title;
  final String description;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
//              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              borderRadius: BorderRadius.circular(32),
              child: Image.network(
                assetName,
                height: MediaQuery.of(context).size.height,
//                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            CardContent(
              title: title,
              description: description,
              offset: gauss,
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String description;
  final double offset;

  const CardContent(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(title,
                style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: primaryBlack,
                    offset: Offset(5.0, 5.0),
                  )
                ])),
          ),
          SizedBox(height: 8),
          Spacer(),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(description,
                style: TextStyle(fontSize: 20, color: Colors.white, shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: primaryBlack,
                    offset: Offset(5.0, 5.0),
                  )
                ])),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
