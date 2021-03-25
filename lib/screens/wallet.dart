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
            //debugPrint('products size: ${snapshot.data!=null}');
            return getWalletScreen(snapshot.data,context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyWallet(context);
          } else {
            return progressBar;
          }
        },
      ),

    );
  }

  Widget getEmptyWallet(BuildContext context) {
    return Container();
  }

}
Widget getWalletScreen(WalletResponse response,BuildContext context,Widget widget){
  return Container(
    child: Column(
      children: [
        getTopWallet(context,response),
        _tabSection(context, response)

      ],
    ),
  );
}
Widget  getTopWallet(BuildContext context,WalletResponse response){
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
                    Text('${response.currency.symbolLeft}${" "}${response.data.balance}',style:TextStyle(color: Colors.white,fontSize: 20),),
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
Widget _tabSection(BuildContext context,WalletResponse response) {
  return DefaultTabController(
    length: 2,

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child:
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TabBar(
                isScrollable: true,
              indicator:  BoxDecoration(
                  color: colorPrimary,
                ),
                labelColor: Colors.white,

                unselectedLabelColor: Colors.black,
                indicatorPadding:EdgeInsets.only(left: 0,right: 0) ,

                tabs: [ Container(

                    height: 30,width: 100,
                    child: Center(child: Text("History"))),
                 Container(
                     height: 30,width: 100,
                     child: Center(child: Text("Upcoming")))],
              ),
            ),
          ),

        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height*0.6,
          child: TabBarView(children: [
            getHistoryData(response.data.history,response.currency.symbolLeft, context),
            getUpcomingData(response.data.pendingHistory, response.currency.symbolLeft,context),

          ]),
        ),
      ],
    ),
  );
}
Widget getHistoryData(List<Wallet> wallets,String currency,BuildContext context) => ListView.builder(
    itemBuilder: (context, index) =>
        getHistory(wallets[index],currency,index),
    itemCount: wallets.length);
Widget getUpcomingData(List<Wallet> wallets,String currency,BuildContext context) => ListView.builder(
    itemBuilder: (context, index) =>
        getUpcoming(wallets[index], currency,index),
    itemCount: wallets.length);
Widget getHistory(Wallet wallet,String Currency,int index){
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index==0?Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ):Container(),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width:150,child: Text(wallet.type,maxLines:3,style: TextStyle(fontSize: 10,color: textColor),)),
                  Container(width:100,child: Text(wallet.date,maxLines:2,style: TextStyle(fontSize: 10,color: textColor),)),
                  Text('$currency${" "}${wallet.amount}',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold,color: colorRed),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ),
        ],
      ),

    ),
  );
}
Widget getUpcoming(Wallet wallet,String Currency,int index){
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index==0?Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ):Container(),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width:150,child: Text(wallet.type,maxLines:3,style: TextStyle(fontSize: 10,color: textColor),)),
                  Container(width:100,child: Text(wallet.date,maxLines:2,style: TextStyle(fontSize: 10,color: textColor),)),
                  Text('$currency${" "}${wallet.amount}',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold,color: colorRed),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Divider(thickness: 1,),
          ),
        ],
      ),

    ),
  );
}