import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'cart.dart';

class ReferScreen extends StatefulWidget {
  String title;
  ReferScreen(String title)
  {
    this.title=title;
  }
  @override
  _ReferScreenState createState() => new _ReferScreenState(title: title);
}
class _ReferScreenState extends State<ReferScreen> {
  String title;
  _ReferScreenState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
            child: ImageIcon(
              AssetImage("assets/icons/nazarath_logo.png"),
              size: appTabImageSize,
            ),
          ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: getReferFriend(),
    );
  }
}
Container getReferFriend()
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
          mobileNumberField,

          RaisedButton.icon(
              onPressed: () async {},
              elevation: 0,
              color: colorPrimary,
              hoverColor: colorPrimary,
              // padding: EdgeInsets.only(left: 5, right: 5),
              textColor: Colors.white,
              label: Text(
                'Refer',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400),
              )),
        ],
      ),
    ),
  );
}
String email;
final mobileNumberField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    email = value;
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
        'assets/icons/emailicon.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
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
    hintText: "Address", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'ADDRESS',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/home.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String location;
final locationField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    location = value;
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
    hintText: "Address", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'ADDRESS',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/location.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String date;
final dateField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    date = value;
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
    hintText: "Date", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'DATE',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/calendar.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String time;
final timeField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    time = value;
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
    hintText: "Time", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'TIME',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon: new IconButton(
      icon: new Image.asset(
        'assets/icons/time.png',
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
