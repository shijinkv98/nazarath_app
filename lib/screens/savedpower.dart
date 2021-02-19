import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/model/file_model.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/EyePowerResponse.dart';
import 'package:nazarath_app/notifiers/register_notifier.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:http/http.dart' as http;
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
      body:FutureBuilder<EyePowerResponse>(
      future: ApiCall()
        .execute<EyePowerResponse, Null>('eye-power/en', null),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    return getSavedEyePower(snapshot.data.data,context,widget);
    } else if (snapshot.hasError) {
      Data data=new Data(id: 0,customerId: 1,prescription: "");
      return getSavedEyePower(data,context,widget);
    } else {
    return progressBar;
    }
    },
    ));
  }
}
Widget getSavedEyePower(Data data,BuildContext context,Widget widget)
{

  return SingleChildScrollView(child: Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Column(
      children: [
        getContainerEyePower(data,context,widget)
      ],
    ),
  ));
}
void setData(Data data)
{
  if(data.rxOdReAxis!=null)
    axixright=data.rxOdReAxis;
  if(data.rxOdReAddv!=null)
    addright=data.rxOdReAddv;
  if(data.rxOdReCyi!=null)
    cylright=data.rxOdReCyi;
  if(data.rxOdReSphere!=null)
    sphereright=data.rxOdReSphere;

  if(data.rxOsLeAxis!=null)
    axixleft=data.rxOsLeAxis;
  if(data.rxOsLeAddv!=null)
    addleft=data.rxOsLeAddv;
  if(data.rxOsLeCyi!=null)
    cylleft=data.rxOsLeCyi;
  if(data.rxOsLeSphere!=null)
    sphereleft=data.rxOsLeSphere;
}
Widget getContainerEyePower(Data data,BuildContext context,Widget widget)
{
  setData(data);
  FileModel _regstraionDoc;
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
                            onPressed: () async {


                              final _allowedDocuments = ['docx', 'pdf', 'doc'];
                              FilePickerResult result =
                              await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: _allowedDocuments,
                              );
                              if (result != null) {
                                _regstraionDoc = FileModel(
                                    fileName: result.files.single.name,
                                    imageStr: result.files.single.path,
                                    imageU8L: result.files.single.bytes);
                                DocsAddedNotifier _docsAddedNotifier;
                                _docsAddedNotifier.docAdded();
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          width: 150,
                          child: _regstraionDoc  != null
                              ? Text(
                            _regstraionDoc.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.red),
                          ):Container(),
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
                                        onPressed: () async {
                                           if(_regstraionDoc!=null)
                                             updatePrescriptionWithPdf(context);
                                            else
                                             updatePrescriptionWithoutPdf(context,_regstraionDoc);
                                        },
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
Future<void> updatePrescriptionWithoutPdf(BuildContext context)
async {
  Map body={
    "right_eye_sphere":sphereright,
    "right_eye_cyi":cylright,
    "right_eye_axis":axixright,
    "right_eye_addv":addright,
    "left_eye_sphere":sphereleft,
    "left_eye_cyi":cylleft,
    "left_eye_axis":axixleft,
    "left_eye_addv":addleft,
  };
  FocusScope.of(context).requestFocus(FocusNode());

  var response = await ApiCall()
      .execute<EyePowerResponse, Null>("eye-power/store/en", body);

  if (response?.data != null) {
    ApiCall().showToast(response.message);
  }
}
void updatePrescriptionWithPdf(BuildContext context,FileModel _regstraionDoc)
{
  var request =
  ApiCall().getMultipartRequest("eye-power/store/en");
  request.fields['right_eye_sphere'] = sphereright;
  request.fields['right_eye_cyi'] = cylright;
  request.fields['right_eye_axis'] = axixright;
  request.fields['right_eye_addv'] = addright;
  request.fields['left_eye_sphere'] = sphereleft;
  request.fields['left_eye_cyi'] = cylleft;
  request.fields['left_eye_axis'] = axixleft;
  request.fields['left_eye_addv'] = addleft;
  if (_regstraionDoc != null) {
    request.files.add(http.MultipartFile.fromBytes(
        'registration_copy',
        File(_regstraionDoc.imageStr).readAsBytesSync(),
        filename: _regstraionDoc.name,
        contentType: MimeTypes.getContentType(_regstraionDoc)));
  }
}
String sphereleft="";
final sphereFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
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
  initialValue: sphereleft,
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

String cylleft="";
final cylFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    cylleft = value;
  },
  initialValue: cylleft,
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
String axixleft="";
final axixFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    axixleft = value;
  },
  initialValue: axixleft,
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
String addleft="";
final addFieldleft = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
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
  initialValue: addleft,
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
String sphereright="";
final sphereFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    sphereright = value;
  },
  initialValue: sphereright,
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
  onChanged: (value) {
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

String cylright="";
final cylFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
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
  initialValue: cylright,
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
String axixright="";
final axixFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    axixright = value;
  },
  initialValue: axixright,
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
String addright="";
final addFieldright = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    addright = value;
  },

  initialValue: addright,
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

