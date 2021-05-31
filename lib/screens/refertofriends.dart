import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/RefferalResponse.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'cart.dart';

class ReferScreen extends StatefulWidget {
  String title;
  ReferScreen(String title) {
    this.title = title;
  }
  @override
  _ReferScreenState createState() => new _ReferScreenState(title: title);
}

class _ReferScreenState extends State<ReferScreen> {
  String title;
  _ReferScreenState({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text('Refer to Friend',style:TextStyle(fontSize:15,color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body:  FutureBuilder<ReferalResponse>(
        future: ApiCall()
            .execute<ReferalResponse, Null>('referral-url/'+selectLanguage, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            ////debugPrint('products size: ${snapshot.data?.news?.length}');
            return SingleChildScrollView(child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  getReferFriend(snapshot.data),
                  getButton(snapshot.data)
                ],
              ),
            ));

          } else if (snapshot.hasError) {
            // return getEmptyContainerOrder(context);
            //return getEditAdress(context,widget,cartresponse,address,type,from);
            return  getEmptyContainer(context, "No data", "empty_cart");
          } else {
            return progressBar;
          }
        },
      )
    );
  }
}

Widget getButton(ReferalResponse referal) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
    child: Container(
      width: double.infinity,
      height: 40,
      child: RaisedButton(
        color: colorPrimary,
        elevation: 0,
        child: Text('Refer',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        onPressed: () async {
          share(referal);
        },
      ),
    ),
  );
}

Container getReferFriend(ReferalResponse data) {
  return Container(
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          getForms(data),
        ],
      ),
    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);
}

Widget getForms(ReferalResponse data) {
  refer=data.referralUrl;
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
            child: referField,
          ),
         ],
      ),
    ),
  );
}
Future<void> share(ReferalResponse referal) async {
  await FlutterShare.share(
      title: referal.details.title,
      text: referal.details.description,
      linkUrl: referal.referralUrl,
      chooserTitle: 'Nazarath'
  );
}

// Future<void> shareFile() async {
//   List<dynamic> docs = await DocumentsPicker.pickDocuments;
//   if (docs == null || docs.isEmpty) return null;
//
//   await FlutterShare.shareFile(
//     title: 'Example share',
//     text: 'Example share text',
//     filePath: docs[0] as String,
//   );
// }
String refer="";
final referField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  initialValue: refer,
  focusNode: new AlwaysDisabledFocusNode(),
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: '',
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
