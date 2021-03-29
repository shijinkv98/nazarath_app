import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/resetpasswordresponse.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/register/otp_reset.dart';
import 'package:nazarath_app/screens/resetpassword.dart';

import 'DashBoard.dart';
import 'cart.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String title;

  ForgotPasswordScreen(String title)
  {
    this.title=title;
  }
  @override
  _ForgotPasswordScreenState createState() => new _ForgotPasswordScreenState(title: title);
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _ForgotPasswordScreenState({ this.title}) ;

  Widget getForms_forgot(){
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 5,left: 25,right: 25,bottom: 20),
        child: Form(
         key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: phoneField,
              ),


            ],
          ),
        ),
      ),
    );
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
            child: Text('Submit',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            // onPressed: (){
            //   showToastMessage('Mobile number not Registered with us');
            // },
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

              }


              Map body={
                "email":phoneNo,
                "phone_country_code":"+91"
              };
              FocusScope.of(context).requestFocus(FocusNode());

              var response = await ApiCall()
                  .execute<ResetPasswordResponse, Null>("send-reset-password-code/en", body);

              if (response!= null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ResetPasswordScreen(code: "+91",number:phoneNo ,)));
              }
            }

        ),
      ),
    );
  }
  // void showToastMessage(String message){
  //   Fluttertoast.showToast(
  //       msg: message, //message to show toast
  //       toastLength: Toast.LENGTH_LONG, //duration for message to show
  //       gravity: ToastGravity.CENTER, //where you want to show, top, bottom
  //       timeInSecForIosWeb: 1, //for iOS only
  //       //backgroundColor: Colors.red, //background Color for message
  //       textColor: Colors.grey, //message text color
  //       fontSize: 16.0 //message font size
  //   );
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text('Forgot Password',style:TextStyle(fontSize:15,color: Colors.white),
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
  Container getPersonalInfo()
  {
    return Container(
      child: Container(width: double.infinity,
        child: Column(

          children: [
            getForms_forgot(),


          ],
        ),

      ),
    );
    //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

  }
}




String phoneNo;
bool isLoading = false;
// _checkBoxNotifier = Provider.of<CheckBoxNotifier>(context, listen: false);
final phoneField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  inputFormatters: [
    new WhitelistingTextInputFormatter(
        new RegExp(r'^[0-9]*$')),
    new LengthLimitingTextInputFormatter(10)
  ],
  onChanged: (value) {
    phoneNo = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return value.length < 10 ? 'Enter a valid mobile number' : null;
    }
  },
  keyboardType: TextInputType.phone,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Phone Number", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Phone Number',
    prefixText: "971",
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    prefixIcon:
    new IconButton(
      icon: new Image.asset(
        'assets/icons/call.png',
        width: register_icon_size,
        height: register_icon_size,
      ),
      onPressed: null,
      color: colorPrimary,
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);

