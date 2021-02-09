import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/home.dart';
import 'package:spinner_input/spinner_input.dart';

class SpinnerCart extends StatefulWidget {
  String slug, store;
  double count;
    SpinnerCart(String slug,String store,String count)
    {
      this.store=store;
      this.slug=slug;
      this.count=double.parse(count);
    }
  @override
  _SpinnerCartState createState() => _SpinnerCartState(slug:this.slug,store:this.store,spinner_cart: this.count);
}


class _SpinnerCartState extends State<SpinnerCart> {
  double spinner_cart = 1;
  String slug, store;
  _SpinnerCartState({this.slug,this.store,this.spinner_cart});
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${"Quantity :"}${spinner_cart.toInt().toString()}',
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
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(0.0)),
                    ),
                    child: SpinnerInput(
                      minValue: 1,
                      maxValue: 200,
                      spinnerValue: spinner_cart,
                      step: 1,
                      disabledLongPress: true,
                      disabledPopup: true,
                      middleNumberStyle: TextStyle(fontSize: 16,color: item_text_gray, fontWeight: FontWeight.bold),
                      middleNumberBackground: Colors.white,
                      plusButton: SpinnerButtonStyle(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          textColor: item_text_gray,

                          elevation: 0
                      ),
                      minusButton: SpinnerButtonStyle(elevation: 0,
                        color: Colors.white, borderRadius: BorderRadius.circular(0),
                        textColor: item_text_gray,

                      ),
                      onChange: (newValue) {
                        setState(() {
                          spinner_cart = newValue;
                          addtoCart(slug, store, context, widget, spinner_cart.toString());
                        });

                        },
                    ),
                  ),
            SizedBox(
              width: 5,
            ),
            removeButtonCart(slug,store,context,widget)
          ],
        ),
      ],
    );

  }
}
GestureDetector removeButtonCart(String slug,String store,BuildContext context,Widget widget)
{
  return GestureDetector(
      onTap: () {
        removeFromCart(slug,store,context,widget);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color:item_text_gray_light),
            borderRadius:  BorderRadius.circular(2)),
        child: Row(
          children: [
            Icon(Icons.delete,color:item_text_gray_light ,size: 20,)
            //Image.asset(Icons.,width: 28,),
          ],
        ),
      )
  );

}