import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/WalletResponse.dart';
import 'package:nazarath_app/screens/order.dart';

class WalletScreen extends StatefulWidget {
  String title;
  WalletScreen(String title)
  {
    this.title=title;
  }
  @override
  _WalletScreenState createState() => new _WalletScreenState(title: title);
}
class _WalletScreenState extends State<WalletScreen> {
  String title;
  _WalletScreenState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title:  Text('Wallet',style:TextStyle(fontSize:15,color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,

      body:
      FutureBuilder<WalletResponse>(
        future: ApiCall()
            .execute<WalletResponse, Null>('wallet/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('products size: ${snapshot.data!=null}');
            return getWalletScreen(snapshot.data,context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainerOrder(context);
          } else {
            return progressBar;
          }
        },
      ),

    );
  }

}
Widget getWalletScreen(WalletResponse response,BuildContext context,Widget widget){
  return Container(
    child: Column(
      children: [
        getTopWallet(context),
        _tabSection(context)

      ],
    ),
  );
}
Widget  getTopWallet(BuildContext context){
  return Container(
    color: product_bg,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(25,25,25,25),
    child: Column(
      children: [
        Container(
          color: colorPrimary,
          height: 90,
        ),
      ],
    ),
  )
  );
}
Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child:
          TabBar(unselectedLabelColor: Colors.black,indicatorColor: Colors.transparent, tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(color:colorPrimary,
                      width: MediaQuery.of(context).size.width/3.5,
                      height:30,
                      child: Tab(text: "History",),
                  )
                  ,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    height:30,
                    child: Tab(text: "Upcoming")),
              ],
            ),
          ]),
          color: Colors.white,
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height*0.6,
          child: TabBarView(children: [
            Text('page 1'),
            Text('page 2'),

          ]),
        ),
      ],
    ),
  );
}