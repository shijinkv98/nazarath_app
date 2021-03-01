// import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/LoginResponse.dart';
import 'package:nazarath_app/screens/forgotpassword.dart';
import 'package:nazarath_app/screens/register/register.dart';

import 'DashBoard.dart';
import 'home.dart';

// show CheckBoxNotifier;
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}
class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 12);
  // CheckBoxNotifier _checkBoxNotifier;

  @override
  Widget build(BuildContext context) {
    String shopName;
    bool isLoading = false;
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
        contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        hintText: "User Name", hintStyle: TextStyle(color: textColorSecondary),
        labelText: 'USERNAME',
        prefixText: "971",
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
        contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        hintText: "Password", hintStyle: TextStyle(color: textColorSecondary),
        labelText: "PASSWORD",
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
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        onPressed: () async {

          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            setState(() {
              isLoading=true;
            });

            // Map body = {
            //   // name,email,phone_number,password
            //   'email_phone': shopName,
            //   'password': password.trim(),
            //   'referral_code': "",
            //   'guest_id':'',
            // };
            // isLoading=true;
            // var response = await ApiCall()
            //     .execute<LoginResponse, Null>("login/en", body);
            //
            // if (response?.customerData != null) {
            //   isLoading=false;
            //   await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => DashBoard()),);
            // }
            login(shopName, "", "", password, context);
          }
         // guestLogin(context);
        },

        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal)),
      ),
    );

    return WillPopScope(
        onWillPop: () async => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Are you sure you want to quit?'), actions: <Widget>[
              RaisedButton(
                  color: colorPrimary,
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(exit(0))),
              RaisedButton(
                  color: colorPrimary,
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ])),
    child:

      Scaffold(
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
              height: 40,
              color: colorPrimary,
            ),
            Container(
              color: colorPrimary,
              child: ImageIcon(
                AssetImage("assets/icons/nazarath_logo.png"),
                color: Colors.white,
                size: 70,
              ),
            ),
            Container(
              width: double.infinity,
              color: colorPrimary,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
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
                            "Login",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
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
                          child: GestureDetector(
                            onTap:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => ForgotPasswordScreen('')));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        loginButon,
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          onPressed: () async {
                            isLoading=true;
                            Map body = {
                              // name,email,phone_number,password
                            };

                            guestLogin(context);
                          },

                          child: Text("Guest",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  fontSize: 14,
                                  color: colorPrimary,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: style.copyWith(
                                    fontSize: 14,
                                    color: textColor,
                                    fontWeight: FontWeight.normal)),
                            TextButton(onPressed: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Register()));
                            }, child: Text("Create Account", style: style.copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))
                            // MaterialButton(
                            //   minWidth: MediaQuery.of(context).size.width,
                            //   onPressed: () {

                            //   },
                            //
                            //   child: Text("  Creat an Account?",
                            //       textAlign: TextAlign.center,
                            //       style: style.copyWith(
                            //           fontSize: 14,
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.bold)),
                            // )
                          ],
                        ),

                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isLoading,
                            child: CircularProgressIndicator()
                        ),

                        // Text("Or Sign in with",
                        //     textAlign: TextAlign.center,
                        //     style: style.copyWith(
                        //         fontSize: 12,color: item_text_gray)),
                        // SizedBox(
                        //   height: 10,
                        // ),
                       // getSocialMediaContainer(context)
                      ],
                    )

                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    ));
    
  }
  Widget getSocialMediaContainer(BuildContext context)
  {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            MaterialButton(
            minWidth:  35.0,
            height: 35,
            elevation: 2.0,
            padding: EdgeInsets.all(0),
            color:Colors.white,
            child:Image.asset('assets/icons/google.png',width: 25,),
            onPressed: (){

            },

            shape: ButtonTheme.of(context).shape,
            ),
              // SignInButtonBuilder(
              //   icon:  ImageIcon( AssetImage('icons/google.png')),//new Image.asset('icons/google.png'),
              //   text: "",
              //   backgroundColor: Colors.white,
              //   mini: true,
              //   onPressed: () {},
              // ),
              SignInButton(
                Buttons.Facebook,
                mini: true,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Twitter,
                mini: true,
                onPressed: () {},
              ),
            ],
          ),
        );
  }
  Future<void> guestLogin(BuildContext context)
  async {
    await ApiCall().saveUser("");
    await ApiCall().saveLoginResponse("");
    Map body = {
      // name,email,phone_number,password
    };
    var response = await ApiCall()
        .execute<LoginResponse, Null>("guest-login/en", body);

    if (response?.customerData != null) {
      isLoading=false;
      await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
      await ApiCall().saveLoginResponse(jsonEncode(response.toJson()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),);
    }
  }
  Future<void> login(String email_phone,String referral_code,String guest_id,String password,BuildContext context)
  async {
    await ApiCall().saveUser("");
    await ApiCall().saveLoginResponse("");
    Map body = {
      // name,email,phone_number,password
      'email_phone': email_phone,
      'password': password.trim(),
      'referral_code': referral_code,
      'guest_id':'',
    };
    var response = await ApiCall()
        .execute<LoginResponse, Null>("login/en", body);

    if (response?.customerData != null) {
      isLoading=false;
      await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
      await ApiCall().saveLoginResponse(jsonEncode(response.toJson()));
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
      await ApiCall().saveLoginResponse(jsonEncode(response.toJson()));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),);
    }
  }
}
