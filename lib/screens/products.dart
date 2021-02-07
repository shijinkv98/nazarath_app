




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
            // getItems(),

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
class getItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
        child: GridView.builder(
      itemCount:5,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        return new Card(

        );
      },
    ),
    );
  }
}