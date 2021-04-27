import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/ChangePasswordResponse.dart';
import 'package:nazarath_app/notifiers/dataupdatenotifier.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:provider/provider.dart';

import 'DashBoard.dart';
import 'cart.dart';

class ChangePasswordScreen extends StatefulWidget {
  String title;
  var customer;
  ChangePasswordScreen(String title,var customer)
  {
    this.title=title;
    this.customer=customer;
  }
  @override
  _ChangePasswordScreenState createState() => new _ChangePasswordScreenState(title: title);
}
 final GlobalKey<FormState> _formKey_chang = GlobalKey<FormState>();
class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String title;
  var customer;
  DataUpdateNotifier _updateNotifier;
  @override
  void initState() {
    _updateNotifier =
        Provider.of<DataUpdateNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _updateNotifier.reset();
    super.dispose();
  }
  _ChangePasswordScreenState({ this.title,this.customer}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text('Change Password',style:TextStyle(fontSize:15,color: Colors.white),
          ),
        ),

      backgroundColor: Colors.white,
      body: getFullView(),
    );
  }
  Widget getFullView()
  {
    return Container(
      child: Stack(
        children: [
          Align(alignment: Alignment.topCenter,
            child: SingleChildScrollView(child:getPassword()),
          ),
          Align(
            alignment: Alignment.center,
            child: Consumer<DataUpdateNotifier>(
              builder: (context, value, child) {
                return _updateNotifier.isProgressShown?progressBar:SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
  Widget getPassword()
  {
    return Container(
      child: Container(width: double.infinity,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  getFormsChangePass(),
                  getButton()

                ],
              ),
            ),


          ],
        ),

      ),
    );

  }
  Widget getFormsChangePass(){
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 15),
        child: Form(
          key: _formKey_chang,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: getCurrentPasswordFeiled(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: getNewPasswordField(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: getConfirmPasswordField(),
              ),

            ],
          ),
        ),
      ),
    );
  }
  String currentpassword;
  String newpassword;
  String confirmpassword;
  void changePassword(String newpassword,String currentpassword, String email)
  {
    Map body = {
      "new_password": newpassword,
      "old_password": currentpassword,
      "email": customer.email,
    };
    FocusScope.of(context).requestFocus(FocusNode());
    _updateNotifier.isProgressShown=true;
   ApiCall()
        .execute<ChangePasswordResponse, Null>(
        "change-password/en", body).then((result) {
      ApiCall().showToast(result.message);
      _updateNotifier.isProgressShown=false;
      tbPosition = 3;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });

  }
  Widget getButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 70,left: 25,right: 25),
      child: Container(
        width: double.infinity,
        height: 40,
        child: RaisedButton(

          color: colorPrimary,
          elevation: 0,
          child: Text('Update', style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white)),
          onPressed: () async {
            if (_formKey_chang.currentState.validate()) {
              _formKey_chang.currentState.save();
              changePassword(newpassword, currentpassword, customer.email);
            }

          },
        ),
      ),
    );
  }
  Widget getCurrentPasswordFeiled()
  {
    return TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      onChanged: (value) {
        currentpassword = value;
      },
      // style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        }
        else if (value.trim().length<8) {
          return 'Minimum 8 character needed';
        }
        else {
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
  }
  Widget getNewPasswordField()
  {
    return  TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      onChanged: (value) {
        newpassword = value;

      },
      // style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        }
        else if (value.trim().length<8) {
          return 'Minimum 8 character needed';
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
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
  }
  Widget getConfirmPasswordField()
  {
    return TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      onChanged: (value) {
        confirmpassword = value;

      },
      // style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        }
        else if (value.trim().length<8) {
          return 'Minimum 8 character needed';
        }
        else if(newpassword!=confirmpassword)
          return ("password do not match");
        else {
          return null;
        }
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
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
  }
}








