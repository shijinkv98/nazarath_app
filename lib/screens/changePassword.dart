import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/ChangePasswordResponse.dart';
import 'package:nazarath_app/screens/notification.dart';

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
      //   backgroundColor: colorPrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: getPassword(context,customer)),
    );
  }
}
Container getPassword(BuildContext context,var customer)
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
                // getForgotPasssword(),
                getButton(context,customer)

              ],
            ),
          ),


        ],
      ),

    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

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
              child: currentpasswordField,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
              child: newpasswordField,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
              child: confirmpasswordField,
            ),

          ],
        ),
      ),
    ),
  );
}
Widget getButton(BuildContext context,var customer){
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
          }
            Map body = {
              "new_password": newpassword,
              "old_password": currentpassword,
              "email": customer.email,
            };
            FocusScope.of(context).requestFocus(FocusNode());

            var response = await ApiCall()
                .execute<ChangePasswordResponse, Null>(
                "change-password/en", body);

            if (response != null) {
              ApiCall().showToast(response.message);
              tbPosition = 3;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),
              );

            //  }
          }
        },
      ),
    ),
  );
}
// Container getForgotPasssword(){
//   return Container(
//     child: Padding(
//       padding: const EdgeInsets.only(right: 30),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//
//         children: [
//           Text('Forgot your password',style: TextStyle(fontSize: 12,color: textColor),),
//         ],
//       ),
//     ),
//   );
// }
String currentpassword;
final currentpasswordField = TextFormField(
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
String newpassword;
final newpasswordField = TextFormField(
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
String confirmpassword;
final confirmpasswordField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    confirmpassword = value;
    if(newpassword!=confirmpassword)
      confirmpasswordField.validator("password do not match");
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



