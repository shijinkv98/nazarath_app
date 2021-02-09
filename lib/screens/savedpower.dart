import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/notification.dart';

import 'cart.dart';

class SavedPowerScreen extends StatefulWidget {
  String title;
  SavedPowerScreen(String title) {
    this.title = title;
  }
  @override
  _SavedPowerScreenState createState() => new _SavedPowerScreenState(title: title);
}

class _SavedPowerScreenState extends State<SavedPowerScreen> {
  String title;
  _SavedPowerScreenState({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title:  Text('Saved Power',style:TextStyle(fontSize:15,color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            getContainerEyePower()
          ],
        ),
      )),
    );
  }
}
Widget getContainerEyePower()
{
  return Container(
    child: Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Upload Prescription',
                      style:
                      TextStyle(color: textColor, fontSize: 12,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            color: colorPrimary,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Upload',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                            ),
                            onPressed: () async {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'myprescription.pdf',
                          style:
                          TextStyle(color: textColor, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 40,bottom: 15),
              child: Text(
                '(upload pdf,jpg,png format)',
                style: TextStyle(color: textColor, fontSize: 9),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 30),
            //   child: Divider(
            //     color: product_bg,
            //     thickness: 2,
            //   ),
            // ),
            Container(
              width: double.infinity,
              color: product_bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,top: 15,left: 25),
                    child: Text(
                      'Eye Power enter manually',
                      style:
                      TextStyle(color: textColor, fontSize: 12,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 10),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 15,left: 25,right: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'RX.OD(left)',
                                    style:
                                    TextStyle(color: textColor, fontSize: 10,fontWeight: FontWeight.bold)
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: sphereFieldleft,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: cylFieldleft,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: axixFieldleft,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: addFieldleft,
                                )
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 25),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 15,left: 25,right: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'RX.OD(Right)',
                                    style:
                                    TextStyle(color: textColor, fontSize: 10,fontWeight: FontWeight.bold)
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: sphereFieldright,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: cylFieldright,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: axixFieldright,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: addFieldright,
                                )
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5,left: 25,right: 25,bottom: 25),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15,top: 15,left: 0,right: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Support(Assist)',
                                      style:
                                      TextStyle(color: textColor, fontSize: 10,fontWeight: FontWeight.bold)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: colorPrimary)
                                        ),
                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.only(left: 25,right: 25),
                                          child: supportassistField,
                                        ))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: RaisedButton(
                                        color: colorPrimary,
                                        elevation: 0,
                                        child: Text('Update',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white)),
                                        onPressed: () async {},
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
String sphereleft;
final sphereFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    sphereleft = value;
  },
  // style: style,
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
    hintText: "Sphere",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Sphere',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),



    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);

String cylleft;
final cylFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    cylleft = value;
  },
  // style: style,
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
    hintText: "CYL",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'CYL',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String axixleft;
final axixFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    axixleft = value;
  },
  // style: style,
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
    hintText: "Axix",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Axix',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String addleft;
final addFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    addleft = value;
  },
  // style: style,
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
    hintText: "Add",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Add',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String sphereright;
final sphereFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    sphereright = value;
  },
  // style: style,
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
    hintText: "Sphere",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Sphere',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),



    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String supportassist;
final supportassistField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    supportassist = value;
  },
  // style: style,
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
    hintText: "Type Here",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Type Here',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),



    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);

String cylright;
final cylFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    cylright = value;
  },
  // style: style,
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
    hintText: "CYL",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'CYL',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String axixright;
final axixFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    axixright = value;
  },
  // style: style,
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
    hintText: "Axix",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Axix',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
String addright;
final addFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    addright = value;
  },
  // style: style,
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
    hintText: "Add",
    hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Add',
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);

