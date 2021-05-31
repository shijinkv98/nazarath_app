import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/helper/mime_type.dart';
import 'package:nazarath_app/model/file_model.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/screens/ordersucess.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/CheckoutResponse.dart';
import 'package:nazarath_app/network/response/ProductDetailsResponse.dart';
import 'package:nazarath_app/notifiers/register_notifier.dart';
import 'package:nazarath_app/screens/searchscreen.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'DashBoard.dart';
import 'cart.dart';
import 'editaddress.dart';
import 'home.dart';
import 'notification.dart';
import 'order.dart';

class CheckoutScreen extends StatefulWidget {
  CartResponse response;
  CheckoutScreen(CartResponse response)
  {
    this.response=response;
  }

  @override
  _CheckoutState createState() => new _CheckoutState(cartResponse: this.response);
}

class _CheckoutState extends State<CheckoutScreen> {
  List data;
  List<Items> products;
  CheckoutResponse Checkoutresponse;
  CartResponse cartResponse;
  _CheckoutState({this.cartResponse});
  FileModel prescription;
  Future<String> getData() async {
    Map body = {
      // name,email,phone_number,passwor
    };
    // Checkoutresponse =
    //     await ApiCall().execute<CheckoutResponse, Null>("Checkout/"+selectLanguage, body);

    // if (Checkoutresponse != null) {
    //   products = Checkoutresponse.orderId.items;
    //   ApiCall().showToast(Checkoutresponse.message);
    // }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
              child: ImageIcon(
                AssetImage("assets/icons/nazarath_logo.png"),
                size: appTabImageSize,
              ),
            ),
          ),
          backgroundColor: colorPrimary,
          elevation: 0,
          actions: <Widget>[
            // ImageIcon(AssetImage("assets/icons/nazarath_logo.png"),size: 100,)
            Padding(
                padding: const EdgeInsets.only(right: appTabIconPad),
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>SearchScreen(from: "",hint: "Search products",)),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(
                      AssetImage("assets/icons/search.png"),
                    ),
                  ),
                )),

            Padding(
                padding: const EdgeInsets.only(right: appTabIconPad),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationScreen("notification")),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(
                      AssetImage("assets/icons/notification.png"),
                    ),
                  ),
                )),

            Padding(
              padding: const EdgeInsets.only(right: appTabIconPad),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(
                    AssetImage("assets/icons/cart.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
        body:customView(context, widget, cartResponse,prescription)

            // FutureBuilder<CheckoutResponse>(
            //   future: ApiCall()
            //       .execute<CheckoutResponse, Null>('Checkout/'+selectLanguage, null),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       //debugPrint('products size: ${snapshot.data?.orderId?.items?.length}');
            //       return _listview(snapshot.data?.orderId?.items
            //           ?.where((element) =>
            //       element != null )
            //           ?.toList(),context,super.widget);
            //     } else if (snapshot.hasError) {
            //       return errorScreen('Error: ${snapshot.error}');
            //     } else {
            //       return progressBar;
            //     }
            //   },
            // ),

        );
  }
}
Widget _itemsBuilder(Products product,BuildContext context,Widget widget) {
  bool status = false;
  return GestureDetector(
    onTap: () {

    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,

            )]
      ),
      child: Container(
          child:
          Padding(
              padding:
              EdgeInsets.fromLTRB(padding, padding, 0, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInImage.assetNetwork(
                      imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace)=>Image(
                        image: AssetImage("assets/images/no_image.png"),
                        fit: BoxFit.cover,
                      ),
                    placeholder: 'assets/images/no_image.png',
                    image: '$productThumbUrl${product.image}',
                    width: 120,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 180,
                        child:Flexible(
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  color: Colors.black,fontSize: 12, fontWeight: FontWeight.w500),
                            )) ,)
                      ,
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text('${product.symbolLeft}${" "}${product.price}${product.symbolRight}',style: TextStyle(
                              color: colorRed,fontSize: 11,fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',style: TextStyle(
                              color: Colors.grey,fontSize: 11,decoration: TextDecoration.lineThrough)),
                        ],
                      ),


                    ],
                  )
                ],
              )
          )

      ),
    ),
  );


}

Widget customView(BuildContext context,Widget widget,CartResponse cartResponse,FileModel doc)
{
  final _itemExtent = 120.0;
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child:    getTopContainer(),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverFixedExtentList(
        itemExtent: _itemExtent,  // I'm forcing item heights
        delegate: SliverChildBuilderDelegate(
              (context, index) => _itemsBuilder(cartResponse.products[index],context,widget),
          childCount: cartResponse.products.length,
        ),
      ),

      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    _tabSection(context,widget,cartResponse,doc),
      ),

    ],
  );
}
Widget getCheckout(BuildContext context,Widget widget,CartResponse cartResponse) {
  return Container(
    child: Column(
      children: [
        getTopContainer(),
       // getProductDetails(context,widget,cartResponse),

        // getTab()
      ],
    ),
  );
}

// Widget getProductDetails(BuildContext context,Widget widget,CartResponse cartResponse) {
//
// }

Container getTopContainer() {
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
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image: new AssetImage("assets/icons/inner_banner.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Checkout",
            style: TextStyle(
                color: text_tilte_page,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Widget _tabSection(BuildContext context,Widget widget,CartResponse cartResponse,FileModel doc) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child:
              TabBar(labelColor: textColor, indicatorColor: product_bg, tabs: [
            Tab(text: "Upload Prescription"),
            Tab(text: "Eye Power enter manually"),
          ]),
          color: Colors.white,
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height*0.6,
          child: TabBarView(children: [
            getTabSection1(context, widget, cartResponse,doc),
            getTabSection2(context, widget, cartResponse)

          ]),
        ),
      ],
    ),
  );
}
Widget getTabSectionNormal(BuildContext context,Widget widget,CartResponse cartResponse,FileModel doc)
{
    return Container(
      child: Container(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 25),
                child: Row(
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
                          onPressed: ()  async {
                            final _allowedDocuments = ['png', 'pdf', 'jpg'];
                            FilePickerResult result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: _allowedDocuments,
                            );
                            if (result != null) {
                              doc = FileModel(
                                  fileName: result.files.single.name,
                                  imageStr: result.files.single.path,
                                  imageU8L: result.files.single.bytes);
                              DocsAddedNotifier _docsAddedNotifier;
                              _docsAddedNotifier.docAdded(result.files.single.name);
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: doc  != null
                          ? Text(
                        doc.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: colorRed),
                      ):Text(
                        "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: colorRed),
                    )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 40),
                child: Text(
                  '(upload pdf,jpg,png format)',
                  style: TextStyle(color: textColor, fontSize: 9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Divider(
                  color: product_bg,
                  thickness: 2,
                ),
              ),



            ],
          ),
        ),
      ),
    );
}
Widget getTabSection1(BuildContext context,Widget widget,CartResponse cartResponse,FileModel doc)
{
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child:    getTabSectionNormal(context,widget,cartResponse,doc),
      ),
      SliverToBoxAdapter(
          child:   getAdress("Delivery Address",context,widget)
      ),
      SliverToBoxAdapter(
        child:    Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Divider(
            color: product_bg,
            thickness: 2,
          ),
        ),
      ),
      SliverToBoxAdapter(
          child:   getAdress("Shipping Address",context,widget)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    getPaymentOptions(),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
          child:    getDetails(context, widget, cartResponse)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
          child:    getButtonContinue(context,widget,cartResponse,doc)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 50.0),
      ),
    ],
  );
}
Widget getTabSection2(BuildContext context,Widget widget,CartResponse cartResponse)
{
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child:    getContainerEyePower(),
      ),

      SliverToBoxAdapter(
          child:   getAdress("Delivery Address",context,widget)
      ),
      SliverToBoxAdapter(
        child:    Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Divider(
            color: product_bg,
            thickness: 2,
          ),
        ),
      ),
      SliverToBoxAdapter(
          child:   getAdress("Shipping Address",context,widget)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    getPaymentOptions(),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
          child:    getDetails(context, widget, cartResponse)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
          child:    getButtonContinue(context,widget,cartResponse,null)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 50.0),
      ),
    ],
  );
}
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

enum BestTutorSite { cashondelivery, onlinepayment, debit, paytm }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  BestTutorSite _site = BestTutorSite.cashondelivery;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: 30,
            child: ListTile(
              title: const Text('Cash on Delivery'),
              leading: Radio(
                value: BestTutorSite.cashondelivery,
                activeColor: colorPrimary,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10),
        //   child: Container(
        //     height: 30,
        //     child: ListTile(
        //       title: const Text('Online Payment'),
        //       leading: Radio(
        //         activeColor: colorPrimary,
        //         value: BestTutorSite.onlinepayment,
        //         groupValue: _site,
        //         onChanged: (BestTutorSite value) {
        //           setState(() {
        //             _site = value;
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10),
        //   child: Container(
        //     height: 30,
        //     child: ListTile(
        //       title: const Text('Debit/Credit Card'),
        //       leading: Radio(
        //         activeColor: colorPrimary,
        //         value: BestTutorSite.debit,
        //         groupValue: _site,
        //         onChanged: (BestTutorSite value) {
        //           setState(() {
        //             _site = value;
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10),
        //   child: Container(
        //     height: 30,
        //     child: ListTile(
        //       title: const Text('Paytm'),
        //       leading: Radio(
        //         activeColor: colorPrimary,
        //         value: BestTutorSite.paytm,
        //         groupValue: _site,
        //         onChanged: (BestTutorSite value) {
        //           setState(() {
        //             _site = value;
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
Widget getPaymentOptions(/*CartResponse rsponse*/)
{
  return
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 25),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Options',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        MyStatefulWidget(),
      ],

    );
}

Widget getShippingAdress()
{

}
Widget getAdress(String title,BuildContext context,Widget widget)
{
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 25),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Text(
                      homeResponse.address.name,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    VerticalDivider(
                      thickness: 1,
                    ),
                    Text(
                      homeResponse.address.mobile,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              homeResponse.address.address,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Container(
          //     child: SizedBox(
          //       height: 40,
          //       child: RaisedButton(
          //         color: colorPrimary,
          //         elevation: 0,
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Text('Change or Add Address',
          //               style: TextStyle(
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.w400,
          //                   color: Colors.white)),
          //         ),
          //         onPressed: ()  {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => EditAddressScreen("checkout,""edit")),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
Future<void> showSucessDialogueBox(CheckoutResponse response,BuildContext context)
{
  return showDialog(context: context,
      builder: (ctx) => AlertDialog(
        title: Text("SUCCESS"),
        content: Container(child:Column(
          children: [
            Text('"INVOICE_NUMBER"${response.orderId.invoiceNumber}'),
            Text('"ORDER ID"${response.orderId.id}'),
          ],
        )),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              );
              Navigator.of(ctx).pop();
            },
            child: Text("Continue"),
          ),

        ],
      ));
}
Future<void> showDialogueBox(CartResponse response,BuildContext context,Widget widget,FileModel doc)
{
  return showDialog(context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirm Order"),
        content: Text("Do you want to place order?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () {
              if(doc!=null)
                checkoutWithPdf(response, context, widget,doc);
              else
              checkoutWithoutPdf(response, context, widget);
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ));
}
Future<void> checkoutWithoutPdf(CartResponse response,BuildContext context,Widget widget)
async{
  Map body={
    "right_eye_sphere":sphereright,
    "right_eye_cyi":cylright,
    "right_eye_axis":axixright,
    "right_eye_addv":addright,
    "left_eye_sphere":sphereleft,
    "left_eye_cyi":cylleft,
    "left_eye_axis":axixleft,
    "left_eye_addv":addleft,
    "payment_mode": "4",
    "billing_address_id":homeResponse.address.id.toString(),
    "shipping_address_id":homeResponse.address.id.toString(),
    "coupon_code":""
  };
  FocusScope.of(context).requestFocus(FocusNode());

  var response = await ApiCall()
      .execute<CheckoutResponse, Null>("checkout/"+selectLanguage, body);

  if (response!= null) {
    ApiCall().showToast(response.message);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => orderSucessScreen(response)),
    );
  }
}
Future<void> checkoutWithPdf(CartResponse response,BuildContext context,Widget widget,FileModel doc)
async {
  var request =
  ApiCall().getMultipartRequest("eye-power/store/"+selectLanguage);
  request.fields['right_eye_sphere'] = sphereright;
  request.fields['right_eye_cyi'] = cylright;
  request.fields['right_eye_axis'] = axixright;
  request.fields['right_eye_addv'] = addright;
  request.fields['left_eye_sphere'] = sphereleft;
  request.fields['left_eye_cyi'] = cylleft;
  request.fields['left_eye_axis'] = axixleft;
  request.fields['left_eye_addv'] = addleft;
  request.fields['billing_address_id'] = homeResponse.address.id.toString();
  request.fields['shipping_address_id'] = homeResponse.address.id.toString();
  request.fields['coupon_code'] = "";
  request.fields['payment_mode'] = "4";
  if (doc != null) {
    request.files.add(http.MultipartFile.fromBytes(
        'prescription',
        File(doc.imageStr).readAsBytesSync(),
        filename: doc.name,
        contentType: MimeTypes.getContentType(doc)));
  }
  FocusScope.of(context).requestFocus(FocusNode());
  var response = await ApiCall()
      .execute<CheckoutResponse, Null>("checkout/"+selectLanguage, null,multipartRequest: request);
  if (response!= null) {
    ApiCall().showToast(response.message);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => orderSucessScreen(response)),
    );
  }
}
Widget getButtonContinue(BuildContext context,Widget widget,CartResponse response,FileModel doc)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 40, right: 20),
        child: Container(
          child: SizedBox(
            width: 150,
            height: 40,
            child: RaisedButton(
              color: colorPrimary,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Continue',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
              onPressed: ()  {
                showDialogueBox(response, context, widget,doc);
              },
            ),
          ),
        ),
      ),
    ],
  );
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
            // Padding(
            //   padding: const EdgeInsets.only(left: 25, top: 25),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(bottom: 15),
            //         child: Text(
            //           'Upload Prescription',
            //           style:
            //           TextStyle(color: textColor, fontSize: 12,fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Row(
            //         children: [
            //           Container(
            //             child: SizedBox(
            //               width: 140,
            //               height: 40,
            //               child: RaisedButton(
            //                 color: colorPrimary,
            //                 elevation: 0,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Text('Upload',
            //                       style: TextStyle(
            //                           fontSize: 15,
            //                           fontWeight: FontWeight.w400,
            //                           color: Colors.white)),
            //                 ),
            //                 onPressed: () async {},
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 15),
            //             child: Text(
            //               'myprescription.pdf',
            //               style:
            //               TextStyle(color: textColor, fontSize: 12),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5, left: 40,bottom: 15),
            //   child: Text(
            //     '(upload pdf,jpg,png format)',
            //     style: TextStyle(color: textColor, fontSize: 9),
            //   ),
            // ),

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
                      padding: const EdgeInsets.only(top: 10,left: 0,right: 0,bottom: 25),
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
                                      'Support(Assist)',
                                      style:
                                      TextStyle(color: textColor, fontSize: 10,fontWeight: FontWeight.bold)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Padding(
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
String supportassist="";
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