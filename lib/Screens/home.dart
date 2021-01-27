import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/Constants/dart/constants.dart';

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

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title),backgroundColor: colorPrimary,),
        backgroundColor: Colors.white,
        body: Center(child: Text('My Page!')),
        drawer: Drawer(

          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //         bottomRight: Radius.circular(45.0)),
              //   ),
              //   width: MediaQuery.of(context).size.width * 0.5,
              //   height: 180,
              //   child: DrawerHeader(
              //
              //     child: Text("Header"),
              //   ),
              // ),
              Expanded(
                  child: Container(
                color: colorPrimary,
                child: ListView(children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(45.0)),
                    ),
                    height: 150,
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only( left: 5),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.grey[300],
                              child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  AssetImage('assets/icons/no_image.png'),

                            ),
                            )

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text('Muhd. Rafeeque',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                width: 180,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: AutoSizeText('muhdsalam@gmail.com',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigator.of(context).pop();
                      },
                    ),
                  )),
                  SizedBox(height: 20,),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/edit_profile.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Edit Profile',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                    // onTap: () {
                    //   Navigator.of(context).pop();
                    // },
                  ),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/my_orders.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('My Orders',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/favourite.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Wishlist',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/wallet.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('My Wallet',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/change_password.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Change Password',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/stores.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Stores',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title:FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/notification.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Notifications',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title:FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/news_white.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('News',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title:FlatButton(
                      color: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ImageIcon(AssetImage('assets/icons/log_out.png'),color: Colors.white,),
                          SizedBox(width: 10),
                          Text('Logout',style:TextStyle(color:Colors.white),)
                        ],
                      ), onPressed: () {},
                    ),
                  )
                ]),
              ))
            ],
          ),
        ));
  }
}
