import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/filterprice.dart';
import '../main.dart';
import 'vertical_tabs.dart';

class FilterScreeen extends StatelessWidget {
  double _lowerValue = 50;
  double _upperValue = 180;

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
                      onTap: () {},
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
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
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
                        Container(child: FilterPrice()),
                        _listviewFilCat(),
                        _listviewFilDelivery()
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(AssetImage('assets/icons/filtercontrol.png'),size: 30,color:colorPrimary),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Apply Filters',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:colorPrimary)),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

//
//   Widget tabsContent(String caption, [String description = '']) {
//     return Container(
//       color: Colors.white,
//       margin: EdgeInsets.all(1),
//       padding: EdgeInsets.all(2),
//       child: Column(
//         children: <Widget>[
//           // Padding(
//           //   padding: const EdgeInsets.fromLTRB(15,20,15,15),
//           //   child: Container(
//           //     height: 30,
//           //     decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius:BorderRadius.all(Radius.circular(5),),
//           //         border: Border.all(color: product_bg)
//           //     ),),
//           // ),
//           Text(
//             caption,
//             style: TextStyle(fontSize: 25),
//           ),
//           Divider(
//             height: 20,
//             color: Colors.white,
//           ),
//           Text(
//             description,
//             style: TextStyle(fontSize: 15, color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }
// }

  Widget _listviewFilCat() =>
      ListView.builder(
          itemBuilder: (context, index) => _itemsBuilder(),
          // separatorBuilder: (context, index) => Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          itemCount: 4);

  Widget _itemsBuilder() {
    bool status = false;
    return GestureDetector(onTap: () {}, child: _listviewCat());
  }

  Widget _listviewCat() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Checkbox(
              value: true,
              activeColor: colorPrimary,
              focusColor: colorPrimary,
              onChanged: (value) {
                // setState(() {
                //   _value = value;
                // });
              },
            ),
            Text('Sunday Offer')
          ],
        ),
      ],
    );
  }

  Widget _listviewFilDelivery() =>
      ListView.builder(
          itemBuilder: (context, index) => _itemsBuilderDel(),
          // separatorBuilder: (context, index) => Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          itemCount: 6);

  Widget _itemsBuilderDel() {
    bool status = false;
    return GestureDetector(onTap: () {}, child: _listviewDel());
  }

  Widget _listviewDel() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Checkbox(
              value: true,
              activeColor: colorPrimary,
              focusColor: colorPrimary,
              onChanged: (value) {
                // setState(() {
                //   _value = value;
                // });
              },
            ),
            Text('Cash on Delivery')
          ],
        ),
      ],
    );
  }
}
