import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'cart.dart';

class ChangePasswordScreen extends StatefulWidget {
  String title;
  ChangePasswordScreen(String title)
  {
    this.title=title;
  }
  @override
  _ChangePasswordScreenState createState() => new _ChangePasswordScreenState(title: title);
}
class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String title;
  _ChangePasswordScreenState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: true,
      //   title: SafeArea(
      //     child: Padding(
      //       padding:
      //       const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
      //       child: ImageIcon(
      //         AssetImage("assets/icons/nazarath_logo.png"),
      //         size: appTabImageSize,
      //       ),
      //     ),
      //   ),
      //   backgroundColor: colorPrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: getPassword(),
    );
  }
}
Container getPassword()
{
  return Container(
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
          currentpasswordField,
          newpasswordField,
          confirmpasswordField,

          RaisedButton.icon(
              onPressed: () async {},
              elevation: 0,
              color: colorPrimary,
              hoverColor: colorPrimary,
              // padding: EdgeInsets.only(left: 5, right: 5),
              textColor: Colors.white,
              label: Text(
                'Update',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400),
              )),
        ],
      ),
    ),
  );
}
String currentpassword;
final currentpasswordField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    currentpassword = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.visiblePassword,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Enter current password ", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'CURRENT PASSWORD',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/password.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String newpassword;
final newpasswordField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    newpassword = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.visiblePassword,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Enter a new password", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'NEW PASSWORD',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/password.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String confirmpassword;
final confirmpasswordField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    confirmpassword = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.visiblePassword,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Re-enter the new password", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'CONFIRM PASSWORD',
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
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);



