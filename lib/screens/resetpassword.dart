import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/custom/PinField.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
// import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/forgotresponse.dart';
import 'package:nazarath_app/network/response/resetpasswordresponse.dart';
// import 'package:nazarath_app/screens/changePassword.dart';
import 'package:nazarath_app/screens/login.dart';
// import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/register/otp.dart';
import 'package:provider/provider.dart';

import 'DashBoard.dart';
import 'cart.dart';

class ResetPasswordScreen extends StatefulWidget {
  String code, number,id;
  ResetPasswordScreen({this.code,this.number,this.id});
  @override
  _ResetPasswordScreenState createState() => new _ResetPasswordScreenState(code: code,number: number,id: id);
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String code, number,id;
  OTPNotifier _otpNotifier;
  final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();
  _ResetPasswordScreenState({ this.code,this.number,this.id}) ;

  @override
  void initState() {
    _otpNotifier = Provider.of<OTPNotifier>(context, listen: false);
    super.initState();

    // _otpNotifier.otpWithoutNotify = widget.userData?.otp;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text(Languages.of(context).resetPassword,style:TextStyle(fontSize:15,color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 50,right: 50),
                    child: getOtpO()),
                getResendOtp(),
                getPersonalInfo(),
                getButton(context,number,code)
              ],
            ),
          )),
    );

  }
  Widget getButton(BuildContext context,String number,String code) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
      child: Container(
        width: double.infinity,
        height: 40,
        child: RaisedButton(
          color: colorPrimary,
          elevation: 0,
          child: Text(Languages.of(context).update,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
          onPressed: () async {
            if (password == repassword) {
              Map body = {
                "email": number,
                "phone_country_code": code,
                "password": password,
                "code": _otpNotifier.otp
              };
              FocusScope.of(context).requestFocus(FocusNode());

              var response = await ApiCall()
                  .execute<ForgotResponse, Null>("reset-password/"+selectLanguage, body);

              if (response != null) {
                if (response.success != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                }

                else {
                  ApiCall().showToast(response.message);
                }
              }
              else {
                ApiCall().showToast(Languages.of(context).passwordNotMatch);
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => Login()));

            }

          }
        ),
      ),
    );
  }
  Widget getResendOtp(){
    return Container(
      margin: EdgeInsets.only(left:50,right: 50,top:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap:() async {
                Map body={
                  "email":number,
                  "phone_country_code":"+91"
                };
                FocusScope.of(context).requestFocus(FocusNode());

                 ApiCall()
                    .execute<ResetPasswordResponse, Null>("send-reset-password-code/"+selectLanguage, body).then((ResetPasswordResponse data){
                      ApiCall().showToast(data.message);

                });
              },
              child: Text(Languages.of(context).resendOtp,style: TextStyle(color: Colors.black,fontSize: 12),)),
        ],
      )
    );
}
  Widget getOtpO(){
    return OTPTextField(
      key:_otpKey,
      width: MediaQuery.of(context).size.width,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 30,
      // otp: _otpNotifier.otp,
      fieldStyle: FieldStyle.underline,

      style: TextStyle(fontSize: 17),
      onCompleted: (pin) {
        _otpNotifier.otpWithoutNotify = pin;
        print("Completed: " + pin);
      },
      onChanged: (value) {
        _otpNotifier.otpWithoutNotify = value;
      },
    );
  }
  Widget getPersonalInfo()
  {
    return Container(
      margin: EdgeInsets.only(top: 45),
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
              child: passwordField(),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: repasswordField()
            ),


          ],
        ),
      ),
    );
  }

  String password="";
  Widget passwordField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      password = value;
    },
    initialValue: password,
    // style: style,
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
      hintText: Languages.of(context).enterNewPassword, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).newPassword,
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
  String repassword="";
  Widget repasswordField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      repassword = value;
    },
    initialValue: repassword,
    // style: style,
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
      hintText: Languages.of(context).confirmPassWord, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).reEnterPaassword,
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
// Widget getOtp(){
//   return Padding(
//    padding: const EdgeInsets.only(top: 5,left: 25,right: 25,bottom: 20),
//     child: Container(
//       child: otpField,
//
//     ),
//   );
// }


