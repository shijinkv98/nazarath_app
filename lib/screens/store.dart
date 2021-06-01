import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/NewsResponse.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/network/response/StoreResponse.dart';
import 'package:nazarath_app/screens/newsDetails.dart';
import 'package:nazarath_app/screens/order.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreScreen extends StatefulWidget {
  String title;
  StoreScreen(String title) {
    this.title = title;
  }
  @override
  _StoreScreenState createState() => new _StoreScreenState(title: title);
}

class _StoreScreenState extends State<StoreScreen> {
  String title;
  _StoreScreenState({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarMain(context),
        backgroundColor: Colors.white,
        body:
            FutureBuilder<StoreResponse>(
              future: ApiCall()
                  .execute<StoreResponse, Null>('stores/'+selectLanguage, null),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //debugPrint('products size: ${snapshot.data?.stores?.length}');
                  return
                    getStoreScreen(snapshot.data.stores,context,super.widget);
                } else if (snapshot.hasError) {
                  getEmptyContainer(context, Languages.of(context).emptyProduct, "empty_cart");
                  return  getEmptyContainer(context, Languages.of(context).noData, "empty_cart");
                } else {
                  return progressBar;
                }
              },
            ),);

           // getNewsScreen(context, widget));
  }
  Widget getStoreScreen(List<Stores> stores,BuildContext context, Widget widget) {

    return Container(
      child: Column(
        children: [
          getTopContainer(),
          getStoreName(),
          // getRegion(),
          Flexible(child: _listview(stores, context, widget))
        ],
      ),
    );

  }
  Widget getTopContainer() {
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

  Widget getStoreName() {
    return Container(
      width: double.infinity,
      color: product_bg,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Center(
            child: Text(
              Languages.of(context).stores,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
            )),
      ),
    );
  }
  Widget _listview(List<Stores> items, BuildContext context, Widget widget) =>
      ListView.builder(
        // padding: EdgeInsets.only(bottom: 70),
          itemBuilder: (context, index) => getListView(items[index], context, widget),
          // separatorBuilder: (context, index) => Divider(
          //       color: Colors.grey,
          //       height: 1,
          //     ),
          itemCount: items.length);


  Widget getRegion() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Container(
        width: double.infinity,
        height: 40,

        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: colorPrimary)),
        // child:DropdownButton<Item>(
        //   hint:  Text("Select item"),
        //   value: selectedUser,
        //   onChanged: (Item Value) {
        //     setState(() {
        //       selectedUser = Value;
        //     });
        //   },
        //   items: users.map((Item user) {
        //     return  DropdownMenuItem<Item>(
        //       value: user,
        //       child: Row(
        //         children: <Widget>[
        //           user.icon,
        //           SizedBox(width: 10,),
        //           Text(
        //             user.name,
        //             style:  TextStyle(color: Colors.black),
        //           ),
        //         ],
        //       ),
        //     );
        //   }).toList(),
        // ),
      ),
    );
  }

  Widget getListView(Stores item, BuildContext context, Widget widget) {
    // if (featured == null)
    //   return Container();
    // else if (featured.length == 0) return Container();
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        // MaterialPageRoute(
        //     builder: (BuildContext context) =>NewsDetailsScreen(item)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color:product_bg),
          ),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: TextStyle(
                              color: colorPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                            item.address,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 20),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(2.0),
                                    bottomLeft: Radius.circular(2.0),
                                    topRight: Radius.circular(2.0),
                                    topLeft: Radius.circular(2.0)),
                              ),
                              child: RaisedButton.icon(
                                  onPressed: () async {
                                    String phone = '$country_code${item.phoneNumber}'
                                    // widget.orderItems.orderData.shippingPhone
                                        ;
                                    if (phone != null && phone.trim().isNotEmpty) {
                                      phone = 'tel:$phone';
                                      if (await canLaunch(phone)) {
                                        await launch(phone);
                                      }
                                    }
                                  },
                                  elevation: 0,
                                  color: Colors.white,
                                  hoverColor: colorPrimary,
                                  icon: Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  // padding: EdgeInsets.only(left: 5, right: 5),
                                  textColor: Colors.black,
                                  label: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 20, left: 10),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(2.0),
                                    bottomLeft: Radius.circular(2.0),
                                    topRight: Radius.circular(2.0),
                                    topLeft: Radius.circular(2.0)),
                              ),
                              child: RaisedButton.icon(
                                  onPressed: () {
                                    navigateTo(item.latitude!=null?ParseLatLonValue(item.latitude):0,
                                        item.longtitude!=null?ParseLatLonValue(item.longtitude):0,item.name);
                                  },
                                  elevation: 0,
                                  color: Colors.white,
                                  hoverColor: colorPrimary,
                                  icon: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  // padding: EdgeInsets.only(left: 5, right: 5),
                                  textColor: Colors.black,
                                  label: Text(
                                    'Map',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void navigateTo(double lat, double lng,String name) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(lat,lng),
      title: name,
    );
    // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    // if (await canLaunch(uri.toString())) {
    // await launch(uri.toString());
    // } else {
    // throw 'Could not launch ${uri.toString()}';
    // }
  }

  double ParseLatLonValue(String value)
  {
    // If it starts and finishes with a quote, strip them off
    if (value.startsWith("\"") && value.endsWith("\""))
    {
      value = value.substring(1, value.length - 2).replaceAll("\"\"", "\"");
    }
    var first=value.split("°");
    double result=0;
    double deg=0,min=0,sec=0;
    if(first.length>1)
    {
      deg = double.parse(first[0]);
      var second=first[1].split("'");
      if(second.length>1)
      {
        min=double.parse(second[0]);
        sec=double.parse(second[1]);
      }

    }
    result = deg + (min / 60) + (sec / 3600);



    return result;
  }
}


