import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:nazarath_app/helper/constants.dart';

class FilterPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  //
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _lowerValue = 50;
  double _upperValue = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Container(
              color: product_bg,
              child: Text('Select Price Range',style: TextStyle(fontSize: 12,color: textColor,fontWeight: FontWeight.bold),),
            ),
          ),
          Container(

            margin: EdgeInsets.only(top: 0, left: 15, right: 15),
            alignment: Alignment.centerLeft,
            child: FlutterSlider(
              key: Key('3343'),
              values: [250, 600],
              rangeSlider: true,
              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: true,
              ),
              max: 700,
              min: 10,
              step: FlutterSliderStep(step: 20),
              jump: true,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _lowerValue = lowerValue;
                _upperValue = upperValue;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
