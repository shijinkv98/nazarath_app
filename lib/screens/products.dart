
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

import 'cart.dart';
import 'notification.dart';

class ProductsScreen extends StatefulWidget {
  String title;
  ProductsScreen(String title)
  {
    this.title=title;
  }
  @override
  _ProductsState createState() => new _ProductsState(title: title);
}
class _ProductsState extends State<ProductsScreen> {
  String title;
  _ProductsState({ this.title}) ;
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Search(product.name)),
                  // );
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
      backgroundColor: product_bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            getTopContainer(),
            getSortFilter(),

          ],
        ),

      )
    );
  }
}
Container getTopContainer() {
  return Container(
    color: product_bg,
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
          height: 15,
        ),
      ],
    ),
  );
}

class getSortFilter extends StatelessWidget{
 @override
 Widget build(BuildContext context){
   return Padding(
     padding: const EdgeInsets.only(left: 10,right: 10),
     child: Container(
       height:36,
       width:double.infinity,
       color: product_bg,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Container(
             height: 36,
             width: MediaQuery.of(context).size.width / 2.2,
             decoration: BoxDecoration(
               border: Border.all(color: colorPrimary)
             ),
             child: Center(child: Text('Sort')),
           ),
           // SizedBox(width: 10,),
           Container(
             height: 36,
             width: MediaQuery.of(context).size.width/ 2.2,
             color: colorPrimary,
             child: Center(child: Text('Filter')),
           )
         ],
       ),

     ),
   );
 }
}
Container getItems() {
  return Container(
    color: product_bg,
    child:GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      children: List.generate(20, (index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 160,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
              ),
              color: Colors.white,
              elevation: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 5),
                      child: Container(
                        height: 70,
                        child: Image(image: new AssetImage('assets/icons/product1.png'),
                          // image: new NetworkImage(
                          //     '$productThumbUrl${featured[index].image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 6),
                        child: Text(
                          'test test',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 35,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {
                                  // Do something
                                  // addtoCart(featured[index].slug, featured[index].store, context, widget,"1");
                                },
                              )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap:(){
                                    // addtoWishList(featured[index].slug, featured[index].store, context, widget);
                                  } ,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8),
                                    child: ImageIcon(
                                      AssetImage(
                                          'assets/icons/favourite.png'),
                                      size: 20,
                                      color: colorPrimary,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 10,
                                  top: 3,
                                  bottom: 8
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '230',
                                    style: TextStyle(
                                        color: colorRed,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '298',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 8,
                                        decoration: TextDecoration
                                            .lineThrough),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
            ),
          ),
        );
      },),
    ),
  
  );
}

