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
        title:  Text('Order Cancellation',style:TextStyle(fontSize:15,color: Colors.white),
        ),
      ),
      backgroundColor: product_bg,
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            _itemsBuilder(context)

          ],
        ),
      )),
    );
  }
}
Widget _itemsBuilder(BuildContext context) {
  bool status = false;

  return  Container(
    margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding:
          EdgeInsets.fromLTRB(10, 10, 5, 10),
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
                      padding: const EdgeInsets.only(bottom:2),
                      child: Text(
                        'invoiceNumber',
                        style: TextStyle(
                            color: item_text_gray,fontSize: 9),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom:5),
                      child: Text(
                        'productName',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: colorPrimary, fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom:5),
                      child: Row(
                        children: [
                          Text('23.00',style: TextStyle(
                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('AED',style: TextStyle(
                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:5),
                      child: Row(
                        children: [
                          Text('Status :',style: TextStyle(
                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Order Placed',style: TextStyle(
                              color: Colors.green,fontSize: 11,fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:5),
                      child: Row(
                        children: [
                          Text('Qty :',style: TextStyle(
                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: 5,
                          ),
                          Text('1.00',style: TextStyle(
                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800))
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