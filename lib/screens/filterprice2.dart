import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FilterPriceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels =RangeLabels('1', "100");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text( 'Flutter RangeSlider Demo'),
      ),
      body: SliderTheme(
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
              gradient: RadialGradient(
                colors: <Color>[
                  Colors.orangeAccent,
                  Color.lerp(Colors.cyan, Colors.black,.01)
                ],
              ),
            ),
            child: RangeSlider(
                divisions: 5,
                activeColor: Colors.red[700],
                inactiveColor: Colors.red[300],
                min: 1,
                max: 100,
                values: values,
                labels: labels,
                onChanged: (value){
                  print("START: ${value.start}, End: ${value.end}");

                  setState(() {
                    values =value;
                    labels =RangeLabels("${value.start.toInt().toString()}\$", "${value.start.toInt().toString()}\$");
                  });
                }
            ),
          ),
        ),
      ),
    );
  }
}