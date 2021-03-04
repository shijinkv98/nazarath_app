import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/response/FilterResponse.dart';

// class FilterPrice extends StatelessWidget {
//   double _lowerValue=0, _upperValue = 0;
//   Filters filters;
//   Currency currency;
//   FilterPrice({this.filters,this.currency});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      body: MyHomePage(
//          filters: this.filters,
//        currency: this.currency,
//      ),
//     );
//   }
// }

class FilterPrice extends StatefulWidget {
  double _lowerValue=0, _upperValue = 0;
  // MyHomePage({Key key, this.title}) : super(key: key);
  //
  // final String title;
  Filters filters;

  String get lowerValue => _lowerValue.toString();
  String get upperValue => _upperValue.toString();
  double getLowerValue()
  {

  }
  Currency currency;
  FilterPrice({this.filters,this.currency});
  @override
  _FilterState createState() => _FilterState(filters: this.filters,currency: this.currency,);
}

class _FilterState extends State<FilterPrice> {

  Filters filters;
  Currency currency;
  _FilterState({this.filters,this.currency});
  @override
  Widget build(BuildContext context) {
    widget._lowerValue=0; widget._upperValue = 0;
    if(filters!=null)
      {
        if(filters.pricevalues.length>1)
          {
            widget._lowerValue= double.parse(filters.pricevalues[0]);
            widget._upperValue= double.parse(filters.pricevalues[1]);
          }

      }

    double step=(widget._upperValue-widget._lowerValue)/50;
    RangeValues values = RangeValues(widget._lowerValue, widget._upperValue);
    RangeLabels labels =RangeLabels(widget._lowerValue.toString(), widget._upperValue.toString());
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
            child:
            SliderTheme(
              data: SliderThemeData(
                // rangeThumbShape: CustomRangeShape(),
                trackHeight: 2,
              ),
              child: Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(
                      Radius.circular(20),
                    ),
                    // gradient: RadialGradient(
                    //   colors: <Color>[
                    //     Colors.orangeAccent,
                    //     Color.lerp(Colors.cyan, Colors.black,.01)
                    //   ],
                    // ),
                  ),
                  child:
                  RangeSlider(
                      divisions: 100,
                      activeColor: colorPrimary,
                      inactiveColor: Colors.grey[300],
                      min: widget._lowerValue,
                      max: widget._upperValue,
                      values: values,
                      labels: labels,
                      onChanged: (value){
                        print("START: ${value.start}, End: ${value.end}");

                        setState(() {
                          values =value;
                          labels =RangeLabels(value.start.toString(),value.end.toString());
                        });
                      }
                  )
                  // RangeSlider(
                  //     divisions: 100,
                  //     activeColor: Colors.red[700],
                  //     inactiveColor: Colors.red[300],
                  //     min: widget._lowerValue,
                  //     max: widget._upperValue,
                  //     values: values,
                  //     labels: labels,
                  //     onChanged: (value){
                  //       print("START: ${value.start}, End: ${value.end}");
                  //       // widget._lowerValue=value.start;
                  //       // widget._upperValue=value.end;
                  //       setState(() {
                  //         values =value;
                  //         widget._lowerValue=value.start;
                  //         widget._upperValue=value.end;
                  //         labels =RangeLabels("${value.start.toInt().toString()}\$", "${value.start.toInt().toString()}\$");
                  //       });
                  //     }
                  // ),
                ),
              ),
            )
            // FlutterSlider(
            //   key: Key('3343'),
            //   values: [widget._lowerValue, widget._upperValue],
            //   rangeSlider: true,
            //   tooltip: FlutterSliderTooltip(
            //     alwaysShowTooltip: true,
            //   ),
            //   max: widget._upperValue,
            //   min: widget._lowerValue,
            //   step: FlutterSliderStep(step: step),
            //   jump: true,
            //
            //   onDragging: (handlerIndex, lowerValue, upperValue) {
            //
            //     setState(() {
            //       widget._lowerValue = lowerValue;
            //       widget._upperValue = upperValue;
            //     });
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
