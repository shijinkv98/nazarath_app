import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/screens/newsDetails.dart';
import 'package:nazarath_app/screens/order.dart';

class NewsScreen extends StatefulWidget {
  String title;
  NewsScreen(String title)
  {
    this.title=title;
  }
  @override
  _NewsState createState() => new _NewsState(title: title);
}
class _NewsState extends State<NewsScreen> {
  String title;
  _NewsState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body:FutureBuilder<OrderResponse>(
        future: ApiCall()
            .execute<OrderResponse, Null>('my-orders/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('products size: ${snapshot.data?.result.data?.length}');
            return getNewsScreen(snapshot.data?.result?.data
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainerOrder(context);
          } else {
            return progressBar;
          }
        },
      ),
      // Column(
      //   children: [
      //     getTopContainer(),
      //     getFeatured()
      //   ],
      // )
    );
  }

}
Container getNewsScreen(List<Data> orders,BuildContext context,Widget widget){
  List<ItemsNew> items=new List<ItemsNew>();
  for(int i=0;i<orders.length;i++)
  {
    for(int j=0;j<orders[i].itemsNew.length;j++)
    {
      items.add(orders[i].itemsNew[j]);
    }
  }
  return Container(
    child: Column(
      children: [
        getTopContainer(),
        getNews(),
        Flexible(child: _listview(items, context, widget))

      ],
    ),
  );
}
Widget _listview(List<ItemsNew> items,BuildContext context,Widget widget) => ListView.builder(
    // padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        getListView(items[index],context,widget),
    // separatorBuilder: (context, index) => Divider(
    //       color: Colors.grey,
    //       height: 1,
    //     ),
    itemCount: items.length);
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
Container getNews(){
  return Container(
    width: double.infinity,
    color: product_bg,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(child: Text('News',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600]),)),
    ),
  );
}
Widget getListView(ItemsNew item,BuildContext context,Widget widget) {
  // if (featured == null)
  //   return Container();
  // else if (featured.length == 0) return Container();
  return GestureDetector(
    onTap: (){Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>NewsDetailsScreen(item)));
    },
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color:Colors.white,
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/no_image.png',
                    image: '$productThumbUrl${item.image}',
                    width: 100
                  ),
                ),
                Flexible(
                  child: Container(
                    color: Colors.white,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item.createdAt,style: TextStyle(color: textColor,fontSize: 12,),textAlign: TextAlign.start,),
                          Text(item.productName,style: TextStyle(color: textColor,fontSize: 15,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
