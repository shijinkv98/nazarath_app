// import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:nazarath_app/Constants/dart/constants.dart';

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
    String email;
    final emailField = TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      // controller: emailController,
      onSaved: (value) {
        email = value;
      },
      style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Invalid email';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        hintText: "Email", hintStyle: TextStyle(color: textColorSecondary),
        labelText: 'EMAIL',
        labelStyle: TextStyle(fontSize: 12, color: textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorPrimary),
        ),
        prefixIcon: new IconButton(
          icon: new Image.asset(
            'assets/icons/mail.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: null,
          color: colorPrimary,
        ),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    String phoneNo;
    final phoneField = TextFormField(
      cursorColor: colorPrimary,
      obscureText: false,
      onSaved: (value) {
        phoneNo = value;
      },
      style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        hintText: "Phone Number",
        hintStyle: TextStyle(color: textColorSecondary),
        labelText: 'PHONE NUMBER',
        labelStyle: TextStyle(fontSize: 12, color: textColor),
        prefixText: '+91 ', prefixStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorPrimary),
        ),
        prefixIcon: new IconButton(
          icon: new Image.asset(
            'assets/icons/call.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: null,
          color: colorPrimary,
        ),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

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
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final loginButon = Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: colorPrimary,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {},
        // async {
        //   if (_formKey.currentState.validate()) {
        //     _formKey.currentState.save();
        //
        //     if (!_checkBoxNotifier.isChecked) {
        //       ApiCall()
        //           .showToast('Please Accept Terms of Use and Privacy Policy');
        //     } else {
        //       Map body = {
        //         // name,email,phone_number,password
        //         'name': shopName.trim(),
        //         'email': email.trim(),
        //         'password': password.trim(),
        //         'phone_number': phoneNo,
        // 'device_token': deviceToken,
        // 'device_id': deviceId,
        // 'device_platform': Platform.isIOS ? '2' : '1',
        // };

        // FocusScope.of(context).requestFocus(FocusNode());
        // var response = await ApiCall()
        //     .execute<SignupResponse, Null>("vendorregistration", body);
        //
        // if (response?.vendorData != null) {
        // Navigator.of(context)
        //     .pushReplacementNamed('vendorDetails', arguments: '');
        // Navigator.of(context)
        //     .pushNamed('otp', arguments: response.vendorData);
        // }
        // }
        // }
        // },
        child: Text("Register",
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
                      height: 25,
                    ),
                    emailField,
                    SizedBox(
                      height: 25,
                    ),
                    phoneField,
                    SizedBox(
                      height: 25,
                    ),
                    // Row(
                    //   children: [
                    //
                    //     Expanded(
                    //       child: RichText(
                    //         text: TextSpan(
                    //           text: "I Accept All The",
                    //           style:
                    //           TextStyle(color: Colors.black, fontSize: 12),
                    //           children: <TextSpan>[
                    //             TextSpan(
                    //                 text: ' Terms of Use',
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: Color(0xFF265c7e),
                    //                 )),
                    //             TextSpan(
                    //               text: ' and',
                    //               style: TextStyle(
                    //                   color: Colors.black, fontSize: 12),
                    //             ),
                    //             TextSpan(
                    //                 text: ' Privacy Policy',
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: Color(0xFF265c7e),
                    //                 )),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    loginButon,
                    SizedBox(
                      height: 10,
                    ),
                    // RichText(
                    //     text: TextSpan(
                    //         text: 'Already have an account?',
                    //         style: TextStyle(color: Colors.black, fontSize: 15),
                    //         children: <TextSpan>[
                    //           TextSpan(
                    //               text: ' Sign in',
                    //               recognizer: new TapGestureRecognizer()
                    //                 ..onTap = () {
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               style:
                    //               TextStyle(color: colorPrimary, fontSize: 15))
                    //         ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
