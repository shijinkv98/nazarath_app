import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
import 'package:nazarath_app/notifiers/cartnotifier.dart';
import 'package:nazarath_app/screens/home.dart';
import 'package:spinner_input/spinner_input.dart';

import '../cart.dart';

class SpinnerCart extends StatefulWidget {
  String slug, store;
  double count;
  Widget superWidget;
  CartUpdatedNotifier notifer;
    SpinnerCart(String slug,String store,String count,Widget superWidget,CartUpdatedNotifier notifer)
    {
      this.store=store;
      this.slug=slug;
      this.count=double.parse(count);
      this.superWidget=superWidget;
      this.notifer=notifer;
    }
  @override
  _SpinnerCartState createState() => _SpinnerCartState(slug:this.slug,store:this.store,spinner_cart: this.count,superWidget: this.superWidget,notifer: this.notifer);
}


class _SpinnerCartState extends State<SpinnerCart> {
  double spinner_cart = 1;
  String slug, store;
  Widget superWidget;
  CartUpdatedNotifier notifer;
  Future<void> getCartResponse()
  async {
    var response = await ApiCall()
        .execute<CartResponse, Null>("'cart/'+selectLanguage", null);
    if(response!=null)
    {
      notifer.cartAdded=response;

    }
  }
  _SpinnerCartState({this.slug,this.store,this.spinner_cart,this.superWidget,this.notifer});
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${Languages.of(context).quantity}${" :"}${spinner_cart.toInt().toString()}',
          style: TextStyle(
              fontSize: 9,
              color: item_text_gray_light,
             )),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                      padding:EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2) ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.5, color:item_text_gray_light),
                        borderRadius:  BorderRadius.circular(2)),
                      child: Container(
                        height: 24,
                        child: SpinnerInput(

                          minValue: 1,
                          maxValue: 200,
                          spinnerValue: spinner_cart,
                          step: 1,
                          disabledLongPress: true,
                          disabledPopup: true,
                          middleNumberStyle: TextStyle(fontSize: 15,color: Colors.grey[700], fontWeight: FontWeight.normal,),
                          middleNumberBackground: Colors.white,
                          plusButton: SpinnerButtonStyle(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                              textColor: Colors.grey[700],

                              elevation: 0
                          ),
                          minusButton: SpinnerButtonStyle(elevation: 0,
                            color: Colors.white, borderRadius: BorderRadius.circular(0),
                            textColor:Colors.grey[700],

                          ),

                          onChange: (newValue) {
                            setState(() {
                              spinner_cart = newValue;
                              addtoCart(slug, store, context, superWidget, spinner_cart.toString());
                            });

                            },
                        ),
                      ),
                    ),

              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: removeButtonCart(slug,store,context,widget),
              )
            ],
          ),
        ],
      ),
    );

  }
  Future<String>addtoCart(String slug,String store,BuildContext context,Widget widget,String quantity) async {

    Map body = {
      "slug":slug,
      "quantity":quantity,
      "store":store
    };
    CartResponse cartResponse = await ApiCall()
        .execute<CartResponse, Null>("cart/add/"+selectLanguage, body);

    if (cartResponse != null) {
     // ApiCall().showToast(cartResponse.message);
      notifer.cartAdded=cartResponse;
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => widget));
    }
    return "Success!";
  }
  GestureDetector removeButtonCart(String slug,String store,BuildContext context,Widget widget)
  {
    return GestureDetector(
        onTap: () {
          removeFromCart(slug,store,context,widget);
        },
        child: Container(
          height: 29,
          padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color:item_text_gray_light),
              borderRadius:  BorderRadius.circular(2)),
          child: Row(
            children: [
              Container(
                  child: ImageIcon(AssetImage('assets/icons/delete.png'),color:item_text_gray_light,size: 15,))
              //Image.asset(Icons.,width: 28,),
            ],
          ),
        )
    );

  }
  Future<String>removeFromCart(String slug,String store,BuildContext context,Widget widget) async {

    Map body = {
      "slug":slug,
      "quantity":"0",
      "store":store
    };
    CartResponse cartResponse = await ApiCall()
        .execute<CartResponse, Null>("cart/add/"+selectLanguage, body);

    if (cartResponse != null) {
      ApiCall().showToast(cartResponse.message);
      notifer.cartAdded=cartResponse;
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => CartScreen()));
    }
    return "Success!";
  }
}
