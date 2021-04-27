import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/TrackOrderResponse.dart';
import 'package:nazarath_app/screens/searchscreen.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'notification.dart';
import 'util.dart';

class TrackingScreen extends StatefulWidget {
  String itemId;
  TrackingScreen(String itemId)
  {
    this.itemId=itemId;
  }
 // TrackingScreen({Key key}) : super(key: key);

  _TrackingScreenState createState() => _TrackingScreenState(itemId: this.itemId);
}

class _TrackingScreenState extends State<TrackingScreen>
  {
  String itemId;

  _TrackingScreenState({this.itemId});
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map body={
      "item_id":itemId
    };

    return Scaffold(
        backgroundColor: Colors.white,
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
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>SearchScreen(from: "",hint: "Search products",)),
                    );
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
          child:FutureBuilder<TrackOrderResponse>(
            future: ApiCall()
                .execute<TrackOrderResponse, Null>('tracking/en', body),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //debugPrint('products size: ${snapshot.data?.data}');
                return getTrackingFull(snapshot.data.data,context,super.widget);
              } else if (snapshot.hasError) {
                return  getEmptyContainer(context, "No data", "empty_cart");
                //return getEmptyContainerCart(context);
              } else {
                return progressBar;
              }
            },
          ),
        )

    );

  }

  Widget getTrackingFull(Data data, BuildContext context, Widget widget) {
    return Container(color:Colors.white,
    child: Column(
      children: [
        getTopContainer(),

        Flexible(
            child: getTrackView(data, context, widget)
          //getTrackOrderView(context, widget, data.timeline)
        )

      ],
    ),);
  }
  Widget getTrackView(Data data, BuildContext context, Widget widget)
  {
    double _itemExtent=80;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.only(top: 10.0),
        ),
        SliverToBoxAdapter(
          child:   Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${"TrackingNO: "}${data.trackingid}',
                  style: TextStyle(
                      color: text_tilte_page,fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10.0),
        ),
        SliverFixedExtentList(
          itemExtent: _itemExtent,  // I'm forcing item heights
          delegate: SliverChildBuilderDelegate(
                (context, index) => _itemsBuilder(data.timeline[index],context,widget,index,data.timeline.length),
            childCount: data.timeline.length,
          ),
        ),
      ],
    );
  }
  Widget getTopContainer()
  {
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
              "Tracking",
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

  getTrackOrderView(BuildContext context, Widget widget, List<Timeline>timelines) => ListView.builder(
      itemBuilder: (context, index) =>
          _itemsBuilder(timelines[index],context,widget,index,timelines.length),
      itemCount: timelines.length);

  _itemsBuilder(Timeline timeline, BuildContext context, Widget widget,int index,int length) {
    return Container(
      padding: EdgeInsets.only(left:20),
      child: Row(
        children: [
          Column(
            children: [
              timeline.description.isEmpty?Image(
                image: new AssetImage("assets/icons/un_processed.png"),
                width: 20,
                height: 20,

              ):Image(
                image: new AssetImage("assets/icons/processed.png"),
                width: 20,
                height: 20,

              ),
              index!=length-1?Container(
                height: 60,
                child: VerticalDivider(
                  color: colorPrimary,
                  thickness: 2,
                ),
              ):  Container(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left:10),
                child: Text('${timeline.statushistory.statusText}${" "}${timeline.statushistory.updatedAt}',style: TextStyle(
                    color: text_tilte_page,fontSize: 12,fontWeight: FontWeight.bold)),
              ),
              timeline.description!=""?
              Container(
                padding: EdgeInsets.only(left:10,top:5),
                child: Text('${timeline.description}${" "}${timeline.updatedAt}',style: TextStyle(
                    color: colorPrimary,fontSize: 12,fontWeight: FontWeight.bold)),
              ):Container()
            ]
          ),
        ],
      ),
    );
  }


}
