import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/AddressResponse.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
import 'package:nazarath_app/network/response/CountryResponse.dart';
import 'package:nazarath_app/screens/address.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'DashBoard.dart';
import 'cart.dart';
import 'checkout.dart';

class EditAddressScreen extends StatefulWidget {
  String from;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String type;
  CartResponse response;
  Addresses address;
  EditAddressScreen(String from,String type,CartResponse response,Addresses address)
  {
    this.from=from;
    this.type=type;
    this.address=address;
    this.response=response;

  }
  @override
  _EditAddressScreenState createState() => new _EditAddressScreenState(from: from,type: type,cartresponse: response,address: this.address);
}
class _EditAddressScreenState extends State<EditAddressScreen> {
  String from;
  String type;
  CartResponse cartresponse;
  Addresses address;
  _EditAddressScreenState({ this.from,this.address,this.type,this.cartresponse}) ;
  @override
  Widget build(BuildContext context) {
    String title="Add Adress";
    if(type=="edit")
      title="Edit Address";
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(
            color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
        backgroundColor:colorPrimary ,
      ),
      backgroundColor: Colors.white,
      body:
      FutureBuilder<CountryResponse>(
        future: ApiCall()
            .execute<CountryResponse, Null>('countries/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            //debugPrint('products size: ${snapshot.data?.news?.length}');
            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: getEditAdress(snapshot.data.countries,context,widget,cartresponse,address,type,from),
            );
          } else if (snapshot.hasError) {
            return  getEmptyContainer(context, "No data", "empty_cart");
            //return errorScreen('Error: ${snapshot.error}');
          } else {
            return progressBar;
          }
        },
      ),
      //getEditAdress(context,widget,cartresponse,address,type,from),
    );
  }
}
Container getEditAdress(List<Countries>countries,BuildContext context,Widget widget,CartResponse cartresponse,Addresses address,String type,String from)
{
  return Container(
    padding: EdgeInsets.only(top:15),
    child: Container(width: double.infinity,
      child: Column(

        children: [
          getForms(countries,context,widget,cartresponse,address,type,from),


        ],
      ),

    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

}
Widget getForms(List<Countries>countries,BuildContext context,Widget widget,CartResponse cartresponse,Addresses addresses,String type,String from){
  String country=countries[0].id.toString();
  if(addresses!=null)
    {
      address=addresses.address;
      state=addresses.state;
      postal=addresses.zipcode;
    }
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10,top: 10),
            child: addressField,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: stateField,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: postalField,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                  onPressed: ()  async {
                    String url="customer-addresses/add/en";
                    if(type=="edit")
                      {
                        url="customer-addresses/edit/en";
                      }
                    Map body={
                      "name":customer.name,
                      "address":address,
                      "country": country,
                      "state":state,
                      "city":"city",
                      "zipcode":postal,
                      "latitude":"0.0",
                      "longtitude":"0.0",
                      "mobile":customer.mobile,
                    };
                    FocusScope.of(context).requestFocus(FocusNode());

                    var response = await ApiCall()
                        .execute<AddressResponse, Null>(url, body);

                    if (response!= null) {
                      ApiCall().showToast(response.message);
                      if(from=="address")
                        {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AddressScreen("")),
                          );
                        }
                      else if(from=="cart")
                      {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      }
                      else if(from=="checkout")
                      {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CheckoutScreen(cartresponse)),
                        );
                      }
                    }
                  }
                  ,
                  elevation: 0,
                  color: colorPrimary,
                  hoverColor: colorPrimary,
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  textColor: Colors.white,
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
String address="";
final addressField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,

  onChanged: (value) {
    address = value;
  },
  initialValue: address,
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Full address(Building name,Area,Location,Street name)", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'ADDRESS*',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/user.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: () async {
       //  Map body={
       //    "address":address,
       //    "zipcode":postal,
       //    "state":state,
       //  };
       // // FocusScope.of(context).requestFocus(FocusNode());
       //
       //  var response = await ApiCall()
       //      .execute<AddressResponse, Null>("customer-addresses/add/en", body);
       //
       //  if (response?.addresses!= null) {
       //  }
      },
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String state="";
final stateField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    state = value;
  },
  // style: style,
  initialValue: state,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "State/Province", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'STATE/PROVINCE',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/user.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: (){

      },
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String postal="";
final postalField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    postal = value;
  },
  initialValue: postal,
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Zip/Postal COde", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'ZIP/POSTAL CODE',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/user.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: (){},
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);



