import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/network/response/ReviewResponse.dart';
import 'package:nazarath_app/screens/orderdetails.dart';

import 'order.dart';


class WriteReviewScreen extends StatefulWidget {
  ItemsNew item;
  WriteReviewScreen(ItemsNew item)
  {
    this.item=item;
  }



  @override
  _WriteReviewScreenState createState() => new _WriteReviewScreenState(item: item);
}
class _WriteReviewScreenState extends State<WriteReviewScreen> {
  ItemsNew item;
  _WriteReviewScreenState({this.item});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        appBar:AppBar(
          centerTitle: false,
          automaticallyImplyLeading: true,
          title: Text('Write Review',style: TextStyle(fontSize: 15),),
          backgroundColor: colorPrimary,
        ),

    body:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
            child:
            Padding(
                padding:
                EdgeInsets.fromLTRB(15,15,15,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: 'assets/images/no_image.png',
                        image: '$productThumbUrl${item.image}',
                        height:80,
                        width:120
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 180,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName,
                                  // product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1.3,
                                      color: Colors.black,fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: getStarRating(1),
                                ),

                              ],
                            ) ,),

                        ],
                      ),
                    )
                  ],
                )
            )

        ),
        Padding(
          padding: const EdgeInsets.only(left: 25,top: 25),
          child: getwriteReview(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25,top: 25,right: 25),
          child: getButton(context,item),
        )

      ],
    ),
    );
  }
}
double rateValue=1;
Container getStarRating(double rating) {
  return Container(
    height: 10,
    child: RatingBar(
        initialRating: rating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 20,
        ratingWidget: RatingWidget(
            full: Icon(Icons.star, color: colorPrimary),
            half: Icon(
              Icons.star_half,
              color: colorPrimary,
            ),
            empty: Icon(
              Icons.star_outline,
              color: colorPrimary,
            )),
        onRatingUpdate: (value) {
          rateValue=value;
        }),
  );
}
Widget getwriteReview(){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WRITE YOUR REVIEW HERE', style: TextStyle(color: textColor,fontSize: 12),),
        Padding(
          padding: const EdgeInsets.only(top: 15,right: 25),
          child: reviewField,
        )

      ],
    ),
  );
}
Widget getButton(BuildContext context,ItemsNew item){

  return Container(
    width: MediaQuery.of(context).size.width,
    height: 45,
    child: RaisedButton(
      color: colorPrimary,
      elevation: 0,
      child: Text('Submit',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white)),
      onPressed: () async {
        String url='${"add-product-review/"}${item.slug}${"/en"}';
        Map body={
            "title":item.productName,
            "message":review,
            "rating":rateValue.toString()
        };
        FocusScope.of(context).requestFocus(FocusNode());

        var response = await ApiCall()
            .execute<ReviewResponse, Null>(url, body);

        if (response!= null) {
          ApiCall().showToast(response.message);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
        }
      },
    ),
  );
}
String review="";
final reviewField = TextFormField(
  keyboardType: TextInputType.multiline,
  maxLines: 5,
  cursorColor: colorPrimary,
  obscureText: false,
  onChanged: (value) {
    review = value;
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
    contentPadding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
    hintText: "Please Write review here", hintStyle: TextStyle(color: textColorSecondary,fontSize: 10,fontWeight: FontWeight.bold),
    labelText: 'Please Write review here',
    helperMaxLines: 5,
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
