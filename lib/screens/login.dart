// import 'dart:io';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/LoginResponse.dart';

import 'DashBoard.dart';
import 'home.dart';

// show CheckBoxNotifier;

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);
  // CheckBoxNotifier _checkBoxNotifier;

  @override
  Widget build(BuildContext context) {
    String shopName;
    // _checkBoxNotifier = Provider.of<CheckBoxNotifier>(context, listen: false);
    final shopNameField = TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      onSaved: (value) {
        shopName = value;
      },
      style: style,
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
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        hintText: "User Name", hintStyle: TextStyle(color: textColorSecondary),
        labelText: 'USERNAME',
        labelStyle: TextStyle(fontSize: 12, color: textColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorPrimary),
          ),


        prefixIcon: new IconButton(
          icon: new Image.asset(
            'assets/icons/user.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: null,
          color: colorPrimary,
        ),

        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    // TextEditingController emailController = new TextEditingController();




    // final TextEditingController passwordController =
    //     new TextEditingController();
    String password;
    final passwordField = TextFormField(
      cursorColor: colorPrimary,
      obscureText: true,
      // controller: passwordController,
      style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        password = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        hintText: "Password", hintStyle: TextStyle(color: textColorSecondary),
        labelText: "PASSWORD",
        labelStyle: TextStyle(fontSize: 12, color: textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorPrimary),
        ),

        prefixIcon: new IconButton(
          icon: new Image.asset(
            'assets/icons/password.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: null,
          color: colorPrimary,
        ),
        // border:
        // OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final loginButon = Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: colorPrimary,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {

          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            login(shopName, "", "", password, context);
          }
         // guestLogin(context);
        },

        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: colorPrimary,
              child: ImageIcon(
                AssetImage("assets/icons/nazarath_logo.png"),
                color: Colors.white,
                size: 80,
              ),
            ),
            Container(
              width: double.infinity,
              color: colorPrimary,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 110),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65.0),
                      topRight: Radius.circular(65.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        shopNameField,
                        SizedBox(
                          height: 25,
                        ),
                        passwordField,
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        loginButon,
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DashBoard()),);
                          },

                          child: Text("Guest",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ),


                      ],
                    )

                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
    
  }
  Future<void> guestLogin(BuildContext context)
  async {
    Map body = {
      // name,email,phone_number,password
    };
    var response = await ApiCall()
        .execute<LoginResponse, Null>("guest-login/en", body);

    if (response?.customerData != null) {
      await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),);
    }
  }
  Future<void> login(String email_phone,String referral_code,String guest_id,String password,BuildContext context)
  async {
    Map body = {
      // name,email,phone_number,password
      'email_phone': email_phone,
      'password': password.trim(),
      'referral_code': referral_code,
      'guest_id':'guest_id',
    };
    var response = await ApiCall()
        .execute<LoginResponse, Null>("login/en", body);

    if (response?.customerData != null) {
      await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),);
    }
  }
  Future<void> forgotPassword(String email,String id,BuildContext context)
  async {
    Map body = {
      // name,email,phone_number,password
      'email': email,
      'id': id,
    };
    var response = await ApiCall()
        .execute<LoginResponse, Null>("verify-email/en", body);

    if (response?.customerData != null) {
      await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),);
    }
  }
}
