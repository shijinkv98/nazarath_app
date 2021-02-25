import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/response/FilterResponse.dart';

class FilterPrice extends StatelessWidget {
  Filters filters;
  Currency currency;
  FilterPrice({this.filters,this.currency});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: MyHomePage(
         filters: this.filters,
       currency: this.currency,
     ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  //
  // final String title;
  Filters filters;
  Currency currency;
  MyHomePage({this.filters,this.currency});
  @override
  _MyHomePageState createState() => _MyHomePageState(filters: this.filters,currency: this.currency,);
}
double _lowerValue=0, _upperValue = 0;
class _MyHomePageState extends State<MyHomePage> {

  Filters filters;
  Currency currency;
  _MyHomePageState({this.filters,this.currency});
  @override
  Widget build(BuildContext context) {
    _lowerValue=0; _upperValue = 0;
    if(filters!=null)
      {
        if(filters.pricevalues.length>1)
          {
            _lowerValue= double.parse(filters.pricevalues[0]);
            _upperValue= double.parse(filters.pricevalues[1]);
          }

      }

    double step=(_upperValue-_lowerValue)/50;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Container(
             color: Colors.white,
              child: Text('Select Price Range',style: TextStyle(fontSize: 12,color: textColor,fontWeight: FontWeight.bold),),
            ),
          ),
          Container(

            margin: EdgeInsets.only(top: 0, left: 15, right: 15),
            alignment: Alignment.centerLeft,
            child: FlutterSlider(
              key: Key('3343'),
              values: [_lowerValue, _upperValue],
              rangeSlider: true,
              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: true,
              ),
              max: _upperValue,
              min: _lowerValue,
              step: FlutterSliderStep(step: step),
              jump: true,

              onDragging: (handlerIndex, lowerValue, upperValue) {

                setState(() {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
