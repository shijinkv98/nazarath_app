import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/custom/PinField.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/LoginResponse.dart';
import 'package:nazarath_app/network/response/SignupResponse.dart';
import 'package:nazarath_app/screens/resetpassword.dart';
import 'package:provider/provider.dart';

import '../DashBoard.dart';

class OTPNotifier extends ChangeNotifier {
  String _otp;
  String get otp => _otp;
  set otp(String otp2) {
    _otp = otp2;
    notifyListeners();
  }

  set otpWithoutNotify(String otp) {
    _otp = otp;
  }
}
class OtpResetScreen extends StatefulWidget {
  final UserData userData;
  OtpResetScreen({Key key, @required this.userData}) : super(key: key);

  @override
  _OtpResetScreenState createState() => _OtpResetScreenState();
}

class _OtpResetScreenState extends State<OtpResetScreen> {
  //OTPNotifier _otpNotifier;
String otp_value="";
  @override
  void initState() {
    super.initState();

   // _otpNotifier = Provider.of<OTPNotifier>(context, listen: false);
  //  _otpNotifier.otpWithoutNotify = widget.userData?.otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verification',
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
              width: double.infinity,
              color: colorPrimary,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 80),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65.0),
                      topRight: Radius.circular(65.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 40),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Enter the code sent to you",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OTPTextField(
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 30,
                    otp: "",
                    fieldStyle: FieldStyle.underline,
                    style: TextStyle(fontSize: 17),
                    onCompleted: (pin) {
                      // _otpNotifier.otpWithoutNotify = pin;
                      print("Completed: " + pin);
                    },
                    onChanged: (value) {
                      otp_value=value;
                      // .otpWithoutNotify = value_otpNotifier;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        var otp =otp_value;

                        if (otp != null &&
                            otp.trim().length == 6 &&
                            widget.userData != null) {
                          Map body = {
                            //phone_number,otp,id,mode=register/change
                            'phone_number': widget.userData.mobile,
                            'otp': otp.trim(),
                            'id': widget.userData.id,
                            'mode': 'register', //register/change
                          };
                          var  response = await ApiCall()
                              .execute<LoginResponse, Null>("verify-otp", body);
                          if (response?.customerData != null) {
                            await ApiCall().saveUser(jsonEncode(response.customerData.toJson()));
                            await ApiCall().saveLoginResponse(jsonEncode(response.toJson()));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResetPasswordScreen('')),);
                          }

                        }
                      },
                      color: colorPrimary,
                      padding: EdgeInsets.all(10),
                      textColor: Colors.white,
                      child: Text('Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Don\'t receive the OTP ?',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' Resend OTP',
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                if (widget.userData != null) {
                                  Map body = {
                                    // phone_number,id,mode=register/change
                                    'phone_number': widget.userData.mobile,
                                    'id': widget.userData.id,
                                    'mode': 'register', //register/change
                                  };
                                  var response = await ApiCall()
                                      .execute<LoginResponse, Null>("send-otp", body);
                                }
                              },
                            style: TextStyle(
                                color: colorPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600))
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

