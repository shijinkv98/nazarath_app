import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/AddressResponse.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/screens/editaddress.dart';

import '../languages.dart';
import 'home.dart';

class AddressScreen extends StatefulWidget {
  String title;
  AddressScreen(String title) {
    this.title = title;
  }
  @override
  _AddressState createState() => new _AddressState(title: title);
}

class _AddressState extends State<AddressScreen> {
  String title;
  List<Address> addresses=new List<Address>();
  _AddressState({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).myAddress,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<AddressResponse>(
        future: ApiCall()
            .execute<AddressResponse, Null>('customer-addresses/'+selectLanguage, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //debugPrint('products size: ${snapshot.data?.addresses?.length}');
            return getAdressFull(
                snapshot.data?.addresses
                    ?.where((element) => element != null)
                    ?.toList(),
                context,
                super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainerAddress(
                context, Languages.of(context).emptyAddress, "empty_cart");
          } else {
            return progressBar;
          }
        },
      ),
    );
  }
  Widget newAddressButton(BuildContext context, String title) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditAddressScreen("address", Languages.of(context).add, null, null)),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
          decoration: BoxDecoration(
              color: colorPrimary, borderRadius: BorderRadius.circular(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
  Widget updateButton(BuildContext context, String title) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
          decoration: BoxDecoration(
              color: colorPrimary, borderRadius: BorderRadius.circular(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }

  Widget getAdressFull(
      List<Address> values, BuildContext context, AddressScreen widget) {
    this.addresses=values;
    if(homeResponse==null)
      {
        if(addresses.length>0)
          addresses[0].isSelected=true;
      }
      else if(homeResponse.address==null)
        {
          if(addresses.length>0)
            addresses[0].isSelected=true;
        }
      else
        {
          for(int i=0;i<addresses.length;i++)
          {
            if(homeResponse.address.id==addresses[i].id)
              addresses[i].isSelected=true;
          }
        }

    return Container(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: _listview(),
            ),
            SizedBox(
              height: 10,
            ),

            updateButton(context, Languages.of(context).update),

            SizedBox(
              height: 10,
            ),
            newAddressButton(context, Languages.of(context).addNewAddress)
          ],
        ),
      ),
    );
  }

  Widget _listview(
      ) =>
      ListView.builder(
          padding: EdgeInsets.only(bottom: 70),
          itemBuilder: (context, index) =>
              _itemsBuilder(addresses[index]),
          itemCount: addresses.length);
  Widget _itemsBuilder(Address address) {
    return GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 8.0,left: 10.0,top:10,right:20),
              padding: const EdgeInsets.only(
                  bottom: 15.0, left: 10.0, top: 15, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
                boxShadow: [],
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
                                      child: VerticalDivider(
                                        width: 1,
                                        color: Colors.black,
                                      )),
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
                            GestureDetector(
                              onTap: ()
                              {
                                homeResponse.address=address;
                                for(int i=0;i<addresses.length;i++)
                                {
                                  addresses[i].isSelected=false;

                                }
                                address.isSelected=true;
                                Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => AddressScreen("")),);

                                //ApiCall().showToast(address.isSelected.toString());
                              },
                              child: Container(width: 30, height: 30,
                                  child: address.isSelected?Image(image:AssetImage('assets/icons/checkicon.png')):Image(image:AssetImage('assets/icons/checkiconinactive.png'))
                                // Checkbox(
                                //   value: true,
                                //   activeColor: colorPrimary,
                                //   focusColor: colorPrimary,
                                //   onChanged: (bool value) {
                                //     setState(() {
                                //       this.value = value;
                                //     });
                                //   },
                                // ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(address.address,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 20),
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
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditAddressScreen("address",
                                                    "edit", null, address)),
                                      );
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
                                      Languages.of(context).edit,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 20, left: 10),
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
                                    onPressed: () async {
                                      Map body = {"address_id": address.id};
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());

                                      var response = await ApiCall()
                                          .execute<AddressResponse, Null>(
                                          "customer-addresses/delete/"+selectLanguage,
                                          body);

                                      if (response != null) {
                                        ApiCall().showToast(response.message);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressScreen("")),
                                        );
                                      }
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
                                      Languages.of(context).delete,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
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
            Divider(
              thickness: 1,
            )
          ],
        ));
  }

  Container getEmptyContainerAddress(
      BuildContext context, String emptyText, String imagename) {
    return Container(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  '${"assets/icons/"}$imagename${".png"}',
                  height: 50,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  emptyText,
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              updateButton(context, Languages.of(context).addAddress)
            ],
          ),
        ));
  }
}



// class CheckBoxItem extends StatefulWidget {
//   Address address;
//   List<Address> addresses;
//   CheckBoxItem({this.address,this.addresses});
//   void setChecked()
//   {
//     for(int i=0;i<addresses.length;i++)
//       {
//         if(address.id==addresses[i].id)
//           address.isSelected=true;
//         else
//         addresses[i].isSelected=false;
//
//       }
//
//   }
//   @override
//   _CheckBoxItemState createState() => _CheckBoxItemState(address: address);
// }
//
// class _CheckBoxItemState extends State<CheckBoxItem> {
//   bool value = false;
//   Address address;
//   _CheckBoxItemState({this.address});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GestureDetector(
//       onTap: (){
//         widget.setChecked();
//         ApiCall().showToast(widget.address.id.toString());
//
//       },
//       child: address.isSelected?Text("Checked"):Text("Unchecked"),
//     );
//     //   child: Checkbox(
//     //     value: address.isSelected,
//     //     activeColor: colorPrimary,
//     //     focusColor: colorPrimary,
//     //     onChanged: (bool value) {
//     //       setState(() async {
//     //
//     //         //this.value = value;
//     //         // if (value) {
//     //         //   String url = "customer-addresses/update/"+selectLanguage;
//     //         //   homeResponse.address=address;
//     //         //   Map body = {
//     //         //     "address_id": address.id.toString(),
//     //         //   };
//     //         //   FocusScope.of(context).requestFocus(FocusNode());
//     //         //
//     //         //   var response = await ApiCall()
//     //         //       .execute<AddressResponse, Null>(url, body);
//     //         //
//     //         //   if (response != null) {
//     //         //     homeResponse.address = response.addresses[0];
//     //         //     ApiCall().showToast(response.message);
//     //         //     // Navigator.pushReplacement(
//     //         //     //   context,
//     //         //     //   MaterialPageRoute(builder: (context) => AddressScreen("")),);
//     //         //   }
//     //         // }
//     //       });
//     //
//     //     },
//     //   ),
//     // ); //Checkbox
//   }
// }
