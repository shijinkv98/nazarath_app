import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'cart.dart';

class EditAddressScreen extends StatefulWidget {
  String from;
  EditAddressScreen(String from)
  {
    this.from=from;
  }
  @override
  _EditAddressScreenState createState() => new _EditAddressScreenState(from: from);
}
class _EditAddressScreenState extends State<EditAddressScreen> {
  String from;
  _EditAddressScreenState({ this.from}) ;
  @override
  Widget build(BuildContext context) {
    String title="Add Adress";
    if(from=="edit")
      title="Edit Address";
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address",style: TextStyle(
            color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
        backgroundColor:colorPrimary ,
      ),
      backgroundColor: Colors.white,
      body: getEditAdress(),
    );
  }
}
Container getEditAdress()
{
  return Container(
    padding: EdgeInsets.only(top:15),
    child: Container(width: double.infinity,
      child: Column(

        children: [
          getForms(),


        ],
      ),

    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

}
Widget getForms(){
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 20),
      child: Column(
        children: [
          addressField,
          stateField,
          postalField,

          RaisedButton(
              onPressed: ()  {},
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
        ],
      ),
    ),
  );
}
String address;
final addressField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    address = value;
  },
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
      onPressed: (){},
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String state;
final stateField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    state = value;
  },
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
      onPressed: (){},
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String postal;
final postalField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    postal = value;
  },
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



