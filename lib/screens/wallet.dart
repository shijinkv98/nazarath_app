import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/NewsResponse.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/screens/newsDetails.dart';
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
        getWalletScreen(context)
      // FutureBuilder<NewsResponse>(
      //   future: ApiCall()
      //       .execute<NewsResponse, Null>('wallet', null),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       debugPrint('products size: ${snapshot.data?.news?.length}');
      //       return getWalletScreen(snapshot.data?.news
      //           ?.where((element) =>
      //       element != null )
      //           ?.toList(),context,super.widget);
      //     } else if (snapshot.hasError) {
      //       return getEmptyContainerOrder(context);
      //     } else {
      //       return progressBar;
      //     }
      //   },
      // ),

    );
  }

}
Widget getWalletScreen(BuildContext context){
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(width: 50,height: 50,
                child: ImageIcon(AssetImage('assets/icons/walleticon.png'),color: Colors.white,size: 30,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Balance',style:TextStyle(color: Colors.white,fontSize: 10),),
                    Text('1800 Dhs',style:TextStyle(color: Colors.white,fontSize: 20),),
                  ],
                ),
              ),
            ],
          ),
        )
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
                      width:120,
                      height:30,
                      child: Tab(text: "History",),
                  ),

                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  color: Colors.red,
                    width:120,
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
            getHistory(),
            getUpcoming()

          ]),
        ),
      ],
    ),
  );
}
Widget getHistory(){
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transfer from reard point',style: TextStyle(fontSize: 10,color: textColor),),
                  Text('18/11/2020, 10:12 am',style: TextStyle(fontSize: 10,color: textColor),),
                  Text('AED 10.00',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold,color: Colors.red),),
                ],
              ),
            ),
          )
        ],
      ),

    ),
  );
}
Widget getUpcoming(){
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transfer from reard point',style: TextStyle(fontSize: 10,color: textColor),),
                  Text('18/11/2020, 10:12 am',style: TextStyle(fontSize: 10,color: textColor),),
                  Text('AED 10.00',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold,color: Colors.red),),
                ],
              ),
            ),
          )
        ],
      ),

    ),
  );
}