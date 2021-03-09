import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';


class FilterPriceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
      ),
      debugShowCheckedModeBanner: false,
      home: FilterPriceDemoMyHomePage(),
    );
  }
}

class FilterPriceDemoMyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FilterPriceDemoMyHomePage> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels =RangeLabels('1', "100");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //
      //   title: Text( 'Flutter RangeSlider Demo'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20,bottom: 30),
            child: Container(
              color: Colors.white,
              child: Text('Select Price Range',style: TextStyle(fontSize: 12,color: textColor,fontWeight: FontWeight.bold),),
            ),
          ),

          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(
                Radius.circular(20),
              ),

            ),
            child:
            RangeSlider(
                divisions: 100,
                activeColor: colorPrimary,
                inactiveColor: Colors.grey[300],
                min: 1,
                max: 100,
                              
                onChanged: (value){
                  print("START: ${value.start}, End: ${value.end}");

                  setState(() {
                    values =value;
                    labels =RangeLabels(value.start.toString(),value.end.toString());
                  });
                }
            ),
          ),
        ],
      ),
    );
  }
}