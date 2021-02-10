import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/AddressResponse.dart';
import 'package:nazarath_app/screens/editaddress.dart';

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
      backgroundColor: Colors.white,
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
            return getEmptyContainerAddress(context,"Address is empty","empty_cart");
          } else {
            return progressBar;
          }
        },
      ),
    );
  }



}
GestureDetector updateButton(BuildContext context,String title)
{
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditAddressScreen("")),);
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
             title,
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
          updateButton(context,"Update")
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
            child: Column(
              children: [
                Container(
                // margin: const EdgeInsets.only(bottom: 8.0,left: 10.0,top:10,right:20),
                  padding:const EdgeInsets.only(bottom: 15.0,left: 10.0,top:15,right:20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [

                  ],
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(address.name,
                                        style: TextStyle(
                                            color: colorPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                          height: 10,
                                          child: VerticalDivider(width: 1,color: Colors.black,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(address.mobile,
                                          style: TextStyle(
                                              color: colorPrimary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 30,
                                  height: 30,

                                  child:Checkbox(
                                    value: true,
                                    activeColor: colorPrimary,
                                    focusColor: colorPrimary,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   _value = value;
                                      // });
                                    },
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                 address.address,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15,bottom: 20),
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(2.0),
                                          bottomLeft: Radius.circular(2.0),
                                          topRight: Radius.circular(2.0),
                                          topLeft: Radius.circular(2.0)),
                                    ),
                                    child: RaisedButton.icon(
                                        onPressed: ()  {


                                        },
                                        elevation: 0,
                                        color: Colors.white,
                                        hoverColor: colorPrimary,
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        // padding: EdgeInsets.only(left: 5, right: 5),
                                        textColor: Colors.black,
                                        label: Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.w400),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15,bottom: 20, left: 10),
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(2.0),
                                          bottomLeft: Radius.circular(2.0),
                                          topRight: Radius.circular(2.0),
                                          topLeft: Radius.circular(2.0)),
                                    ),
                                    child: RaisedButton.icon(
                                        onPressed: () {
                                          // String phone ='+916238839396'
                                          //     // widget.orderItems.orderData.shippingPhone
                                          // ;
                                          // if (phone != null && phone.trim().isNotEmpty) {
                                          //   phone = 'tel:$phone';
                                          //   if (await canLaunch(phone)) {
                                          //     await launch(phone);
                                          //   }
                                          // }
                                        },
                                        elevation: 0,
                                        color: Colors.white,
                                        hoverColor: colorPrimary,
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        // padding: EdgeInsets.only(left: 5, right: 5),
                                        textColor: Colors.black,
                                        label: Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.w400),
                                        )),
                                  ),

                                ),
                              ],
                            ),

                          ],
                        ),

                      ),

                    ),

                  ),
                ),
                Divider(thickness: 1,)

              ],
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
            updateButton(context, "Add Address")
          ],),
      )
  );



}