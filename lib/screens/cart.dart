import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/CartResponse.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/notifiers/cartnotifier.dart';
import 'package:nazarath_app/screens/checkout.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

import 'DashBoard.dart';
import 'ProductDetails.dart';
import 'custom/spinner_cart.dart';
import 'editaddress.dart';
import 'home.dart';
import 'notification.dart';
// void main() {
//   runApp(Cart(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class CartScreen extends StatefulWidget {
  @override
  _CartState createState() => new _CartState();
}
class _CartState extends State<CartScreen> {
  List data;
  List<Products> products;
  CartResponse cartresponse;
  var login_data;
  CartUpdatedNotifier _updateNotifier;
  @override
  void initState() {
    _updateNotifier =
        Provider.of<CartUpdatedNotifier>(context, listen: false);
    this.getData();
    super.initState();
  }
  Future<String> getData() async {
    login_data=await ApiCall().getLoginResponse();
    return "Success!";
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: product_bg,
      appBar: AppBar(
        centerTitle: true,
          automaticallyImplyLeading: true,
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Search(product.name)),
                  // );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(AssetImage("assets/icons/search.png"),),
                ),
              )
          ),

          Padding(
              padding: const EdgeInsets.only(right: appTabIconPad),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationScreen("notification")),
                  );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(AssetImage("assets/icons/notification.png"),),
                ),
              )
          ),

          Padding(
              padding: const EdgeInsets.only(right: appTabIconPad),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishListScreen()),
                  );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(AssetImage("assets/icons/favorite.png"),),
                ),
              )
          ),

        ],
      ),
      body:Container(
        child:FutureBuilder<CartResponse>(
          future: ApiCall()
              .execute<CartResponse, Null>('cart/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //debugPrint('products size: ${snapshot.data?.products?.length}');
              return getCartScreen(snapshot.data);
            } else if (snapshot.hasError) {
              //return errorScreen('Error: ${snapshot.error}');
              return getEmptyContainerCart(context);
            } else {
              return progressBar;
            }
          },
        ),
      )

      );

  }
  Future<void> getCartResponse()
  async {
    var response = await ApiCall()
        .execute<CartResponse, Null>("'cart/en'", null);
    if(response!=null)
      {
        _updateNotifier.cartAdded=response;

      }
  }
  Widget getCartScreen(CartResponse cartResponse)
  {
    cartresponse=cartResponse;
    _updateNotifier.cartAdded=cartResponse;

    return Consumer<CartUpdatedNotifier>(
      builder: (context, value, child) {
        return value.cartAdded!=null ? getCartFull(value.cartAdded) : SizedBox();
      },
    );

  }
  Widget getCartFull(CartResponse cartResponse)
  {

    if(cartResponse==null)
      return getEmptyContainerCart(context);
    else if(cartResponse.products==null)
      return getEmptyContainerCart(context);
    else if(cartResponse.products.length==0)
      return getEmptyContainerCart(context);
    return  Container(
          child: Container(width: double.infinity,
            child: Column(

              children: [
                getTopContainer(),
                Flexible(
                    child: customView(context, widget, cartResponse,login_data)
                  //_listview(cartResponse.products,context,widget,),

                ),
                //getDetails(context,widget,cartResponse)
              ],
            ),

          ),
        );


    //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

  }

  Widget _listview(List<Products> products,BuildContext context,Widget widget) => ListView.builder(
      itemBuilder: (context, index) =>
          _itemsBuilder(products[index],context,widget),
      // separatorBuilder: (context, index) => Divider(
      //       color: Colors.grey,
      //       height: 1,
      //     ),
      itemCount: products.length);

  Widget _itemsBuilder(Products product,BuildContext context,Widget widget) {
    bool status = false;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(product.slug)),
        );
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
                EdgeInsets.fromLTRB(padding, padding, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/no_image.png',
                      image: '$productThumbUrl${product.image}',
                      width: 120,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 180,
                          child:Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.3,
                                color: Colors.black,fontSize: 12, fontWeight: FontWeight.w500),
                          ) ,)
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
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SpinnerCart(product.slug,product.storeslug,product.quantity,widget,_updateNotifier),

                          ],
                        )

                      ],
                    )
                  ],
                )
            )

        ),
      ),
    );


  }
  Widget customView(BuildContext context,Widget widget,CartResponse cartResponse,var login_data)
  {
    final _itemExtent = 155.0;
    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: _itemExtent,  // I'm forcing item heights
          delegate: SliverChildBuilderDelegate(
                (context, index) => _itemsBuilder(cartResponse.products[index],context,widget),
            childCount: cartResponse.products.length,
          ),
        ),
        // SliverToBoxAdapter(
        //   child:Flexible(child:  _listview(cartResponse.products,context,widget)),
        // ),
        // SliverGrid(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 1,
        //       childAspectRatio: 2.5,
        //       mainAxisSpacing: 0.0,
        //       crossAxisSpacing: 0.0),
        //   delegate: SliverChildBuilderDelegate(
        //         (context, index) {
        //       return _itemsBuilder(products[index],context,widget);
        //     },
        //     childCount: products.length,
        //   ),
        // ),

        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10.0),
        ),
        SliverToBoxAdapter(
          child:   getDiscountButton(context,widget),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10.0),
        ),
        SliverToBoxAdapter(
          child:   getDetails(context,widget,cartResponse),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10.0),
        ),
        SliverToBoxAdapter(
          child:   getPlaceOrderButton(context,widget,cartResponse,login_data),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 30.0),
        )
      ],
    );
  }
  @override
  void dispose() {
    _updateNotifier.reset();
    super.dispose();
  }
}

// Widget getSpinner(String slug,String store)
// {
//   return SpinnerCart(slug,store);
// }

Future<String>removeFromCart(String slug,String store,BuildContext context,Widget widget) async {

  Map body = {
    "slug":slug,
    "quantity":"0",
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/en", body);

  if (cartResponse != null) {
    ApiCall().showToast(cartResponse.message);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String> movetoWishList(String slug,String store,BuildContext context,Widget widget) async {

  Map body = {
    "slug":slug,
    "quantity":"1",
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/move/en", body);

  if (cartResponse != null) {
    ApiCall().showToast(cartResponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}


Container getTopContainer()
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
                padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
                child: Container(
                    height: 125,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/inner_banner.png"),
                          fit: BoxFit.fitWidth,
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
            "Your Cart",
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
Container getEmptyContainerCart(BuildContext context)
{
  return Container(
    height: double.infinity,
    child: Center(
      child:Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Image.asset(
                "assets/icons/empty_cart.png",height: 50,),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
                child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(
                      color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Material(
          elevation: 0.0,
          borderRadius: BorderRadius.circular(5.0),
          color: colorPrimary,
          child: MaterialButton(
            minWidth: 100,
            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),);
            },

            child: Text("Continue Shopping",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal)),
          )
        ),
      ],),
    )
  );



}
Widget getSpinner(String store,String slug,Widget widget,BuildContext context)
{
  Container(
    padding:EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2) ,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 0.5, color:item_text_gray_light),
      borderRadius:
      BorderRadius.only(bottomRight: Radius.circular(0.0)),
    ),
    child: SpinnerInput(
      spinnerValue: 1,
      minValue: 1,
      maxValue: 200,
      step: 1,
      disabledLongPress: true,
      disabledPopup: true,
      middleNumberStyle: TextStyle(fontSize: 12),
      middleNumberBackground: Colors.white,
      plusButton: SpinnerButtonStyle(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          textColor: Colors.black,

          elevation: 0
      ),
      minusButton: SpinnerButtonStyle(elevation: 0,
        color: Colors.white, borderRadius: BorderRadius.circular(0),
        textColor: Colors.black,

      ),
      onChange: (newValue) {
          addtoCartReferesh(slug, store, context, widget, newValue.toString());
      },
    ),
  );
}
Widget getDiscountButton(BuildContext context,Widget widget)
{
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,

    ),
    margin: EdgeInsets.only(left: 10,right: 10),
    child:Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width*0.70,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: couponField,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                          bottomRight:Radius.circular(10) ),
                      color: colorPrimary,

                    ),
                  // height: 50,
                  padding: EdgeInsets.only(left: 25 ,right: 25),
                  child: Center(child: Text(
                      "Apply",
                      style: TextStyle(
                          color: Colors.white, fontSize: 11)),
                  )
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
String coupon;
final couponField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    coupon = value;
  },
  // style: style,
  // validator: (value) {
  //   if (value.trim().isEmpty) {
  //     return 'This field is required';
  //   } else {
  //     return null;
  //   }
  // },
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    hintText: "Discount code ", hintStyle: TextStyle(color: textColor ,fontSize: 12),
    // labelText: 'Discount code',
    // labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide.none,

    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),


    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
  ),
);
Widget getPlaceOrderButton(BuildContext context,Widget widget,CartResponse response,var login_data)
{
  return Container(
    color: product_bg,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 40,right: 40,top:15,bottom: 15),
          color: colorPrimary,
          child: GestureDetector(

            onTap: (){
              if(login_data.guest_id != null && login_data.guest_id.length>0)
                          gotoLogin(context);
              else
                {
                  if(homeResponse.address==null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditAddressScreen("cart","add",response,null)),
                    );
                  }
                  else
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutScreen(response)),
                      );
                    }
                }
            },
              child: Text(
                        "Place Order",
                        style: TextStyle(
                            color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),

          ),
        ),
      ],
    ),
  );
  // return Container(
  //
  //   child: GestureDetector(
  //       onTap: () {
  //
  //       },
  //       child: Container(
  //         padding: EdgeInsets.fromLTRB(10, 10,10, 10),
  //         width:200,
  //         decoration: BoxDecoration(
  //             color: colorPrimary,
  //             borderRadius:  BorderRadius.circular(3)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Center(child:  Text(
  //               "Place Order",
  //               style: TextStyle(
  //                   color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
  //             )
  //           ],
  //         ),
  //       )
  //   ),
  // );
}
Widget getDetails(BuildContext context,Widget widget,CartResponse cartResponse)
{
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(left:10,top: 15),
            child: Text(
              "Order Summary",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: text_tilte_page,fontSize: 14,fontWeight: FontWeight.bold,),
            ),
          ),

          getTextContainer("Sub Total", '${cartResponse.symbolLeft}${" "}${cartResponse.netTotal}', "normal", item_text_gray_light, item_text_gray_light, "normal"),
          getTextContainer("Shipping", '${cartResponse.symbolLeft}${" "}${cartResponse.deliveryCharge.toString()}', "normal", item_text_gray_light, item_text_gray_light, "normal"),
          getTextContainer("Total", '${cartResponse.symbolLeft}${" "}${cartResponse.grandTotal}', "bold", text_tilte_page, colorRed, "title")
        ],

      ),
    );
}
Widget getTextContainer(String title, String value,String style,Color color1,Color color2,String type)
{

  return Container(

    padding:EdgeInsets.only(left: 10,right: 10,top: 15) ,
    color: Colors.white,
    child: Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(title, color1, 12, type, style,TextAlign.start),
                getText(value, color2, 12, type, style,TextAlign.end)

              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1,
        )
      ],
    ),
  );
}
Future<String>addtoCartReferesh(String slug,String store,BuildContext context,Widget widget,String quantity) async {

  Map body = {
    "slug":slug,
    "quantity":quantity,
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/en", body);

  if (cartResponse != null) {
    // ApiCall().showToast(cartResponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Text getText(String title,Color color,double size,String type,String style,TextAlign alignment)
{
  if(type=="title")
    size=14.0;
  if(style=="bold") {
    return
      Text(
          title,
          textAlign: alignment,
          style: TextStyle(
            color: color, fontSize: size, fontWeight: FontWeight.bold));
  }
  return
    Text(
        title,
        style: TextStyle(
          color: color, fontSize: size));
}
///