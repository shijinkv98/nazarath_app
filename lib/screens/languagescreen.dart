import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nazarath_app/helper/constants.dart';

import '../languages.dart';


class languageScreen extends StatefulWidget{
  String title;
  languageScreen(String title)
  {
    this.title=title;
  }
  @override
  languageScreenState createState() => new languageScreenState(title: title);
}

class languageScreenState extends State<languageScreen> {
  String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: font_size_head);
  languageScreenState({ this.title}) ;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title:  Text(Languages.of(context).labelSelectLanguage,style:TextStyle(fontSize:15,color: Colors.white),
          ),
        ),
        body: getLanguageContent()
    );
  }
  Widget getLanguageContent()
  {
    return
      Container(
      child:
      Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 40.7),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ArabicButton(),
                    EnglishButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  Widget ArabicButton() {
    return Container(
      padding: const EdgeInsets.only(right: 20,left: 20,top:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: zredBorder,
              child: InkWell(
                  onTap: () async {
                    changeLanguage(context, "ar");
                    Navigator.pop(context);
                  },
                  child: Center(child: Text("عربى",style: TextStyle(fontFamily: "bold_font",fontSize: 18,color:colorPrimary ))))),
        ],
      ),
    );
  }
  Widget EnglishButton() {
    return Container(
      padding: const EdgeInsets.only(right: 20,left: 20,top:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: filledBorder,
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              child: InkWell(
                  onTap: () async {
                    changeLanguage(context, "en");
                    Navigator.pop(context);
                  },
                  child: Center(child: Text("English",style: TextStyle(fontFamily: "bold_font",fontSize: 18,color:Colors.white ),)))),
        ],
      ),
    );
  }
}