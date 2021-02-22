import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';

import 'util.dart';

class TrackingScreen extends StatefulWidget {
  String itemId;
  TrackingScreen(String itemId)
  {
    this.itemId=itemId;
  }
 // TrackingScreen({Key key}) : super(key: key);

  _TrackingScreenState createState() => _TrackingScreenState(itemId: this.itemId);
}

class _TrackingScreenState extends State<TrackingScreen>
    with TickerProviderStateMixin {
  String itemId;
  AnimationController animationController;
  _TrackingScreenState({this.itemId});
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 8800),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBar(
      controller: animationController,
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final dotSize = 20.0;

  AnimatedBar({Key key, this.controller})
      : dotOneColor = ColorTween(
    begin: FoodColors.Grey,
    end: FoodColors.Yellow,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.000,
        0.100,
        curve: Curves.linear,
      ),
    ),
  ),
        textOneStyle = TextStyleTween(
          begin: TextStyle(fontWeight: FontWeight.w400, color: FoodColors.Grey,fontSize: 12),
          end: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000,
              0.100,
              curve: Curves.linear,
            ),
          ),
        ),
        progressBarOne = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.450),
          ),
        ),
        dotTwoColor = ColorTween(
          begin: FoodColors.Grey,
          end: FoodColors.Yellow,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.450,
              0.550,
              curve: Curves.linear,
            ),
          ),
        ),
        textTwoStyle = TextStyleTween(
          begin: TextStyle(fontWeight: FontWeight.w400, color: FoodColors.Grey, fontSize: 12),
          end: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.450,
              0.550,
              curve: Curves.linear,
            ),
          ),
        ),
        progressBarTwo = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.550, 0.900),
          ),
        ),
        dotThreeColor = ColorTween(
          begin: FoodColors.Grey,
          end: FoodColors.Yellow,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.900,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        textThreeStyle = TextStyleTween(
          begin: TextStyle(fontWeight: FontWeight.w400, color: FoodColors.Grey, fontSize: 12),
          end: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.900,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<Color> dotOneColor;
  final Animation<TextStyle> textOneStyle;
  final Animation<double> progressBarOne;
  final Animation<Color> dotTwoColor;
  final Animation<TextStyle> textTwoStyle;
  final Animation<double> progressBarTwo;
  final Animation<Color> dotThreeColor;
  final Animation<TextStyle> textThreeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35,left: 30),
              child: Container(
                width: 10,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Text('${(controller.value * 100.0).toStringAsFixed(1)}%'),
                    Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(dotSize / 2),
                          color: dotOneColor.value),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 2,
                        child: LinearProgressIndicator(
                          backgroundColor: FoodColors.Grey,
                          value: progressBarOne.value,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(FoodColors.Yellow),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(dotSize / 2),
                          color: dotTwoColor.value),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 2,
                        child: LinearProgressIndicator(
                          backgroundColor: FoodColors.Grey,
                          value: progressBarTwo.value,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(FoodColors.Yellow),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(dotSize / 2),
                          color: dotThreeColor.value),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,30,20,20),
              child: Container(
                margin: EdgeInsets.only(top: 5),
                width: 20  ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Recieved',
                      style: textOneStyle.value,
                    ),
                    Text(
                      'Preparing',
                      style: textTwoStyle.value,
                    ),
                    Text(
                      'Ready',
                      style: textThreeStyle.value,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Container getTopContainer()
{
  return Container(
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
                child: Container(
                    height: 125,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/inner_banner.png"),
                          fit: BoxFit.fitWidth,
                        )
                    )
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Your Cart",
            style: TextStyle(
                color: text_tilte_page,fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );

}