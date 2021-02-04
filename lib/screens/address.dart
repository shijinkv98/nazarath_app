import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/AddressResponse.dart';

import 'DashBoard.dart';

class AddressScreen extends StatefulWidget {
  String title;
  AddressScreen(String title)
  {
    this.title=title;
  }
  @override
  _AddressState createState() => new _AddressState(title: title);
}
class _AddressState extends State<AddressScreen> {
  String title;
  _AddressState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("My Addresses",style: TextStyle(
            color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
        backgroundColor:colorPrimary ,
      )
      ,
      backgroundColor: product_bg,
      body: FutureBuilder<AddressResponse>(
        future: ApiCall()
            .execute<AddressResponse, Null>('customer-addresses/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('products size: ${snapshot.data?.addresses?.length}');
            return getAdressFull(snapshot.data?.addresses
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainer(context,"Address is empty","empty_cart");
          } else {
            return progressBar;
          }
        },
      ),
    );
  }



}
GestureDetector updateButton(BuildContext context)
{
  return GestureDetector(
      onTap: () {

      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
        decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius:  BorderRadius.circular(3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
           Center(child:  Text(
             "Update",
             style: TextStyle(
                 color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      )
  );

}
Widget getAdressFull(List<Addresses> adresses, BuildContext context, AddressScreen widget) {
  return Container(
    child: Container(width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _listview(adresses,context,widget),
          ),
          SizedBox(
            height: 10,
          ),
          updateButton(context)
        ],
      ),

    ),
  );
}

Widget _listview(List<Addresses> adresses,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(adresses[index],context,widget),

    itemCount: adresses.length);
Widget _itemsBuilder(Addresses address,BuildContext context,Widget widget) {
  return
    GestureDetector(
        onTap: () {

        },
            child: Container(
            margin: const EdgeInsets.only(bottom: 8.0,left: 10.0,top:10,right:20),
              padding:const EdgeInsets.only(bottom: 15.0,left: 10.0,top:15,right:20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.white,
              boxShadow: [
              BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              ),
              ],
              ),
              child: Column(
                children: [
                  Text(address.address,style: TextStyle(
                      color: Colors.black26,fontSize: 12)),
                ],
              ),
            )
      );


}
Container getEmptyContainerAddress(BuildContext context,String emptyText,String imagename)
{
  return Container(
      height: double.infinity,
      child: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                '${"assets/icons/"}$imagename${".png"}',height: 50,),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                emptyText,
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(5.0),
                color: colorPrimary,
                child: MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),);
                  },

                  child: Text("Continue Shopping",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal)),
                )
            ),
          ],),
      )
  );



}