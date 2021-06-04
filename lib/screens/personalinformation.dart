import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
// import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/ProfileResponse.dart';
import 'package:nazarath_app/notifiers/dataupdatenotifier.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
import 'package:nazarath_app/screens/profile.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  String title;
  ProfileResponse customer;
  PersonalInfoScreen(String title,ProfileResponse customer)
  {
    this.title=title;
    this.customer=customer;
  }
  @override
  _PersonalInfoScreenState createState() => new _PersonalInfoScreenState(title: title,customer:customer);
}
class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String title;
  _PersonalInfoScreenState({ this.title,this.customer}) ;
  ProfileResponse customer;
  DataUpdateNotifier _updateNotifier;

  @override
  void dispose() {
    _updateNotifier.reset();
    super.dispose();
  }
  @override
  void initState() {
    _updateNotifier =
        Provider.of<DataUpdateNotifier>(context, listen: false);
    getData();
    super.initState();

  }
  Future<void> getData()
  async {
    email=customer.email;
    username=customer.name;
    phonenumber=customer.phoneNumber;
    // ApiCall().getUser().then((UserData data){
    //   customer=data;
    //   email=customer.email;
    //   username=customer.name;
    //   phonenumber=customer.mobile;
    // });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title:  Text(Languages.of(context).personalInformation,style:TextStyle(fontSize:15,color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body:
        Container(
          child: Stack(
            children: [
              Align(alignment: Alignment.topCenter,
                child:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          getPersonalInfo(),
                          getButton(context,customer)
                        ],
                      ),
                    )),
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
        )

    );
  }
  Widget getButton(BuildContext context,var customer) {
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
            _updateNotifier.isProgressShown=true;
            Map body={
              "name":username,
              "email":email,
              "phone_number":phonenumber,
            };
            FocusScope.of(context).requestFocus(FocusNode());

            var response = await ApiCall()
                .execute<String, Null>("update-profile/"+selectLanguage, body);
            _updateNotifier.isProgressShown=false;
            if (response!= null) {
              customer.name=username;
              customer.email=email;
              customer.phoneNumber=phonenumber;
              print(customer.toJson().toString());
              ApiCall().showToast("Update Successfully");
          //    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashBoard()));
              //ApiCall().saveUser(customer.toJson().toString());
            }
          },
        ),
      ),
    );
  }

  Widget getPersonalInfo()
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
        padding: const EdgeInsets.only(top: 5,left: 25,right: 25,bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: usernameField(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: emailField(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: phonenumberField(),
            ),


          ],
        ),
      ),
    );
  }
  String email="";
  Widget emailField ()=> TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      email = value;
    },
    initialValue: email,
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
          'assets/icons/mailicon.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );
  String username="";
  Widget usernameField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      username = value;
    },
    initialValue: username,
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
  String phonenumber="";
  Widget phonenumberField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      phonenumber = value;
    },
    initialValue: phonenumber,
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
      hintText: Languages.of(context).phoneNumber, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).phoneNumber,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),


      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/mobile.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );


  Widget getTopContainer()
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
              Languages.of(context).howItWorks,
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

}
