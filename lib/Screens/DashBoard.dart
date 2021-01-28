import 'package:flutter/material.dart';
import 'file:///D:/0Likhin/nazarath_app/lib/helper/constants.dart';
import 'package:nazarath_app/Screens/login.dart';

import 'home.dart';
import 'profile.dart';
import 'register/register.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoard createState() => _DashBoard();
}

int tbPosition = 1;
TextStyle _optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

List<Widget> _widgetOptions = <Widget>[
  Profile(),
  Profile(),
  Profile(),
  Profile(),
  Profile(),
  // Text(
  //   'Others',
  //   style: _optionStyle,
  // ),
  // Text(
  //   'Others2',
  //   style: _optionStyle,
  // ),
];

class _DashBoard extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    debugPrint('MJM HomeScreen build()');

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: colorPrimary,
          child: TabBar(
            tabs: [
              _individualTab('assets/icons/home_white.png'),
              _individualTab2('assets/icons/check_up_white.png'),
              _individualTab3('assets/icons/stores_white.png'),
              _individualTab4('assets/icons/profile_white.png'),
              _individualTab5('assets/icons/news_white.png'),
              // Tab(
              //   icon: ImageIcon(AssetImage('assets/icons/bottom_nav/Email.png')),
              // ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.all(0),
            indicatorPadding: EdgeInsets.all(0),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Home(),
            Register(),
            Login(),
            Profile(),
            Profile(),
          ],
        ),
      ),
    );
  }
}

Widget _individualTab(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: colorPrimary, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath)),
              text: 'HOME',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey[300],
              width: 1,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab2(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: colorPrimary, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath)),
              text: 'CHECKUP',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey[300],
              width: 1,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab3(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: colorPrimary, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath)),
              text: 'STORES',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey[300],
              width: 1,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab4(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: colorPrimary, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath)),
              text: 'PROFILE',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey[300],
              width: 1,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab5(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: colorPrimary, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath)),
              text: 'NEWS',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey[300],
              width: 1,
              height: 50,
            ),
          )
        ],
      ));
}
