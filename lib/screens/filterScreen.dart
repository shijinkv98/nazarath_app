import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'vertical_tabs.dart';

class FilterScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        automaticallyImplyLeading: true,
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios)),
        title: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
            child: ImageIcon(
              AssetImage("assets/icons/nazarath_logo.png"),
              size: appTabImageSize,
            ),
          ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
            color: product_bg,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.refresh_rounded),
                        Text('Clear All'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: VerticalTabs(
                  tabsWidth: 80,
                  direction: TextDirection.ltr,
                  contentScrollAxis: Axis.vertical,
                  changePageDuration: Duration(milliseconds: 020),
                  tabs: <Tab>[
                    Tab(child: Text('Price')),
                    Tab(child: Text('Categories')),
                    Tab(child: Text('Delivery Options')),
                  ],
                  contents: <Widget>[
                    tabsContent('Flutter', 'www.fluttertutorial.in'),
                    tabsContent('Dart'),
                    Container(
                      child: FlutterSlider(
                        values: [30, 420],
                        rangeSlider: true,
                        max: 500,
                        min: 0,
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          _lowerValue = lowerValue;
                          _upperValue = upperValue;
                          setState(() {});
                        },
                      ),
                    )// tabsContent('NodeJS'),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget tabsContent(String caption, [String description = '']) {

    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(15,20,15,15),
          //   child: Container(
          //     height: 30,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius:BorderRadius.all(Radius.circular(5),),
          //         border: Border.all(color: product_bg)
          //     ),),
          // ),
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(
            height: 20,
            color: Colors.white,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
