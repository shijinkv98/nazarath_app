import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'DashBoard.dart';
import 'cart.dart';

class PersonalInfoScreen extends StatefulWidget {
  String title;
  PersonalInfoScreen(String title)
  {
    this.title=title;
  }
  @override
  _PersonalInfoScreenState createState() => new _PersonalInfoScreenState(title: title);
}
class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String title;
  _PersonalInfoScreenState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    email=customer.email;
    username=customer.name;
    phonenumber=customer.mobile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text('Personal Information',style:TextStyle(fontSize:15,color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                getPersonalInfo(),
                getButton(context)
              ],
            ),
          )),
    );
  }
}
Widget getButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
    child: Container(
      width: double.infinity,
      height: 40,
      child: RaisedButton(
        color: colorPrimary,
        elevation: 0,
        child: Text('Update',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        onPressed: () async {
          Map body={
            "name":username,
            "email":email,
            "phone_number":phonenumber,
          };
          FocusScope.of(context).requestFocus(FocusNode());

          var response = await ApiCall()
              .execute<String, Null>("update-profile/en", body);

          if (response!= null) {
            customer.name=username;
            customer.email=email;
            customer.mobile=phonenumber;
            print(response);
            print(customer.toJson().toString());
           //ApiCall().saveUser(customer.toJson().toString());
          }
        },
      ),
    ),
  );
}

Container getPersonalInfo()
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
      padding: const EdgeInsets.only(top: 5,left: 25,right: 25,bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: usernameField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: emailField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: phonenumberField,
          ),


        ],
      ),
    ),
  );
}
String email="";
final emailField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    email = value;
  },
  initialValue: email,
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
    hintText: "Enter friend email id", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'EMAIL',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/mailicon.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String username="";
final usernameField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    username = value;
  },
  initialValue: username,
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
    hintText: "User Name", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'USER NAME',
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
String phonenumber="";
final phonenumberField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    phonenumber = value;
  },
  initialValue: phonenumber,
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
    hintText: "Phone Number", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'PHONE NUMBER',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/mobile.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);


Container getTopContainer()
{
  return Container(
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                child: Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/inner_banner.png"),
                          fit: BoxFit.fill,
                        )
                    )
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "How it works",
            style: TextStyle(
                color: text_tilte_page,fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );

}
