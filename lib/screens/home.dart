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
          future: ApiCall()
              .execute<HomeResponse, Null>('home/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getFullView(snapshot.data,context);
            } else if (snapshot.hasError) {
              return errorScreen('Error: ${snapshot.error}');
            } else {
              return progressBar;
            }
          },
        )
    );
  }
}
SingleChildScrollView getFullView(HomeResponse homeResponse,BuildContext context)
{
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
                padding: const EdgeInsets.only(top: 10,left: 35,right: 35),
                child: Container(
                    height: 180,
                    // width: 320,

                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image:new AssetImage("assets/icons/homebanner.png"),
                          fit: BoxFit.fill,
                        ))),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
              child:getCategory(homeResponse.categories)
          ),
        )
      ],
    ),
  );
}
Container getCategory(List<Categories> categories){
  if(categories==null)
    return Container();
  else if(categories.length==0)
    return Container();
  return Container(
    child: Container(width: double.infinity,
      child: Column(
        children: [
          Text("Categories",style: TextStyle(fontSize: 15,color: Colors.grey[600],fontWeight:FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            color: Colors.white,
            height:120,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:categories.length, itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                child: Container(
                    child:  Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage('https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(categories[index].category.name,style: TextStyle(fontSize: 15,color: Colors.black),),
                        ),
                      ],
                    )
                ),
              );
            }),
          ),
        ],
      ),

    ),


);
}