import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/screens/sideDrawer.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  final appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  AppLifecycleState _notification;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // drawer: SideDrawer(),
        body: FutureBuilder<HomeResponse>(
          future: ApiCall().execute<HomeResponse, Null>('home/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getFullView(snapshot.data, context);
            } else if (snapshot.hasError) {
              return errorScreen('Error: ${snapshot.error}');
            } else {
              return progressBar;
            }
          },
        ));
  }
}

SingleChildScrollView getFullView(
    HomeResponse homeResponse, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120.0),
                      bottomLeft: Radius.circular(120.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
                child: Container(
                    height: 180,
                    // width: 320,

                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image: new AssetImage("assets/icons/homebanner.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(child: getCategory(homeResponse.categories)),
        ),
        getFeatured(homeResponse.newarrivals)
      ],
    ),
  );
}

Container getCategory(List<Categories> categories) {
  if (categories == null)
    return Container();
  else if (categories.length == 0) return Container();
  return Container(
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Categories",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            height: 120,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Container(
                        child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            categories[index].category.name,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}

Container getFeatured(List<Newarrivals> featured) {
  if (featured == null)
    return Container();
  else if (featured.length == 0) return Container();
  return Container(
    child: Container(
      width: double.infinity,
      color: Color(0xFFe5eeef),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Featured Products",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
            color: Color(0xFFe5eeef),
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5, top: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: Container(
                                child: Image(
                                  image: new AssetImage(
                                      'assets/icons/product1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 7, right: 6),
                                child: Text(
                                 featured[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 35,
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                           bottomLeft: Radius.circular(10)
                                      )
                                  ),
                                  child: Center(child:IconButton(
                                    icon:  Icon(Icons.add,color: Colors.white,size: 22,),
                                    onPressed: (){
                                      // Do something
                                    },
                                  )
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      child:InkWell(
                                        // onTap: ,
                                        child:  Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: ImageIcon(
                                            AssetImage('assets/icons/favourite.png'),
                                            size: 20,
                                            color: colorPrimary,
                                          ),
                                        ),
                                     )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 10,top: 3,),
                                      child: Row(
                                        children: [
                                          Text('${featured[index].symbolLeft}${" "}${featured[index].price}${featured[index].symbolRight}',style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5),
                                          Text('${featured[index].symbolLeft}${" "}${featured[index].oldprice}${featured[index].symbolRight}',style: TextStyle(color: Colors.grey[700],fontSize: 10,decoration: TextDecoration.lineThrough),),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            )
                        ]
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
