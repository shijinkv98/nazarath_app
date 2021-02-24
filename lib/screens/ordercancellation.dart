import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/filterprice.dart';
import '../main.dart';
import 'vertical_tabs.dart';

class OrderCancelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Text(
          'Order Cancellation',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      backgroundColor: product_bg,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [_itemsBuilder(context), getReasonForCancellation(context)],
        ),
      )),
    );
  }
}

Widget _itemsBuilder(BuildContext context) {
  bool status = false;

  return Container(
    margin: const EdgeInsets.only(bottom: 5.0, left: 0.0, top: 5, right: 0),
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/no_image.png',
                image: 'assets/images/no_image.png',
                width: 120,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        'invoiceNumber',
                        style: TextStyle(color: item_text_gray, fontSize: 9),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'productName',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('23.00',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('AED',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('Status :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Order Placed',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('Qty :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('1.00',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget getReasonForCancellation(BuildContext context) {
  return Container(
    color: Colors.white,
    // child: Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(2)),
    //     border: Border.all(color: product_bg)
    //   ),
    child:

        Container(height: 300,
            width: MediaQuery.of(context).size.width, child: Column(
          children: [
            DropDown(),
            getTellUsMore(),
            getButton()
          ],
        )),
    // ),
  );
}
Widget getButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
    child: Container(
      width: double.infinity,
      height: 40,
      child: RaisedButton(
        color: colorPrimary,
        elevation: 0,
        child: Text('Submit',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        onPressed: () async {},
      ),
    ),
  );
}

Widget getTellUsMore(){
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left:20,top: 10,right: 20),
      child: Container(
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(color: colorPrimary),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: tellusmoreField,
          ))),
    ),
  );
}
String tellusmore="";
final tellusmoreField = TextFormField(
  keyboardType: TextInputType.multiline,
  maxLines: 5,
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    tellusmore = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  // keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(0,2, 0, 0.0),
    hintText: "Tell us more(optional)", hintStyle: TextStyle(color: textColorSecondary,fontSize: 14,fontWeight: FontWeight.bold),

    helperMaxLines: 5,
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),




    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  String dropdownValue = 'Please select a reason for cancellation';

  List<String> spinnerItems = [
    'Item not fit',
    'low quality',
    'ordered by mistake',
    'find new model',
    'Please select a reason for cancellation'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: colorPrimary),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 18),
              underline: Container(
                height: 1,
                color: Colors.white,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),

      // Text('Selected Item = ' + '$dropdownValue',
      //     style: TextStyle
      //       (fontSize: 22,
      //         color: Colors.black)),
    ]);
  }
}
