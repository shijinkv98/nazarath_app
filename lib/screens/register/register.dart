// import 'dart:io';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


import 'package:flutter/gestures.dart';
import 'package:nazarath_app/Screens/register/otp.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/SignupResponse.dart';
import 'package:nazarath_app/notifiers/register_notifier.dart';
import 'package:nazarath_app/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// show CheckBoxNotifier;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterLoadingNotifier _loadingNotifier;
  @override
  void initState() {
    _loadingNotifier =
        Provider.of<RegisterLoadingNotifier>(context, listen: false);
    super.initState();
  }
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: font_size_head);

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
          return Languages.of(context).thisFieldRequired;
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        hintText: Languages.of(context).userName, hintStyle: TextStyle(color: textColorSecondary),
        labelText: Languages.of(context).userNameCaps,
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
          return Languages.of(context).thisFieldRequired;
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
        contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        hintText: Languages.of(context).email, hintStyle: TextStyle(color: textColorSecondary),
        labelText: Languages.of(context).emailCaps,
        labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorPrimary),
        ),
        prefixIcon: new IconButton(
          icon: new Image.asset(
            'assets/icons/mail.png',
            width: register_icon_size,
            height: register_icon_size,
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
      inputFormatters: [
        new WhitelistingTextInputFormatter(
            new RegExp(r'^[0-9]*$')),
        new LengthLimitingTextInputFormatter(10)
      ],
      onSaved: (value) {
        phoneNo = value;
      },
      style: style,
      validator: (value) {
        if (value.trim().isEmpty) {
          return Languages.of(context).thisFieldRequired;
        } else {
          return value.length < 10 ? 'Enter a valid mobile number' : null;
        }
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
        hintText: "Phone Number",
        hintStyle: TextStyle(color: textColorSecondary),
        labelText: 'PHONE NUMBER',
        labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
        prefixText: '+971 ', prefixStyle: TextStyle(color: Colors.grey),
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

    // final TextEditingController passwordController =
    //
    //     new TextEditingController();

    String password;
    final passwordField = TextFormField(
      cursorColor: colorPrimary,
      obscureText: true,
      // controller: passwordController,
      style: style,
      // inputFormatters: [
      //   new WhitelistingTextInputFormatter(
      //       new RegExp(r'^[0-9]*$')),
      //   new LengthLimitingTextInputFormatter(20)
      // ],
      validator: (value) {
        if (value.trim().isEmpty) {
          return Languages.of(context).thisFieldRequired;
        }
        else if (value.trim().length<8) {
          return 'Minimum 8 character needed';
        }
        else {
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
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final loginButon = Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: colorPrimary,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(register_icon_size, padding, register_icon_size, padding),
        onPressed: ()
        async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            {
              Map body = {
                // name,email,phone_number,password
                'name': shopName.trim(),
                'email': email.trim(),
                'password': password.trim(),
                'phone_number': phoneNo,
                'phone_country_code': '+91',
                'referral_code': '',
                'guest_id': '',
                'device_token': deviceToken,
                'device_id': deviceId,
                'device_platform': Platform.isIOS ? '2' : '1',
              };

              FocusScope.of(context).requestFocus(FocusNode());
              _loadingNotifier.isLoading = true;
              var response = await ApiCall()
                  .execute<SignupResponse, Null>("register/"+selectLanguage, body);
              if (response != null) {
                _loadingNotifier.isLoading = false;
                if (response?.customerData != null) {
                  // Navigator.of(context)
                  //     .pushReplacementNamed('HomePage', arguments: '');
                  // SharedPreferences preferences = await SharedPreferences
                  //     .getInstance();
                  // await preferences.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        OtpScreen(userData: response.customerData)),);
                }
              }
            }
        }
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: button_text_size,
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
        leading:Container(
            height: 20,
            width: 55,
            child: GestureDetector(
             onTap:() => Navigator.of(context).push(new MaterialPageRoute(builder: (_)=> Login())),
                child: Icon(Icons.arrow_back_sharp,color: Colors.white,)),),
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children:[Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: colorPrimary,
                    padding:EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: ImageIcon(
                      AssetImage("assets/icons/nazarath_logo.png"),
                      color: Colors.white,
                      size: register_logo_size,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: colorPrimary,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: primary_margin),
                      height: container_space,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(border_radius),
                            topRight: Radius.circular(border_radius)),
                      ),
                    ),
                  ),
                  Container(


                    child: Padding(
                      padding: EdgeInsets.fromLTRB(forms_padding, 0, forms_padding, 0),
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
                                    fontSize: header_text_size),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            shopNameField,
                            SizedBox(
                              height: space,
                            ),
                            passwordField,
                            SizedBox(
                              height: space,
                            ),
                            emailField,
                            SizedBox(
                              height: space,
                            ),
                            phoneField,
                            SizedBox(
                              height: space,
                            ),
                            // Row(
                            //   children: [
                            //
                            //     Expanded(
                            //       child: RichText(
                            //         text: TextSpan(
                            //           text: "I Accept All The",
                            //           style:
                            //           TextStyle(color: Colors.black, fontSize: field_text_size),
                            //           children: <TextSpan>[
                            //             TextSpan(
                            //                 text: ' Terms of Use',
                            //                 style: TextStyle(
                            //                   fontSize: field_text_size,
                            //                   color: Color(0xFF265c7e),
                            //                 )),
                            //             TextSpan(
                            //               text: ' and',
                            //               style: TextStyle(
                            //                   color: Colors.black, fontSize: field_text_size),
                            //             ),
                            //             TextSpan(
                            //                 text: ' Privacy Policy',
                            //                 style: TextStyle(
                            //                   fontSize: field_text_size,
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
                  ),
                ],
              ),
                Consumer<RegisterLoadingNotifier>(
                  builder: (context, value, child) {
                    return value.isLoading ? progressBar : SizedBox();
                  },
                )
            ]
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _loadingNotifier.reset();
    super.dispose();
  }
}
