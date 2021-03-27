import 'package:flutter/material.dart';
import 'package:nazarath_app/notifiers/cartnotifier.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
import 'package:nazarath_app/screens/Splash.dart';
import 'package:nazarath_app/screens/register/otp.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart';
import 'network/ApiCall.dart';
import 'notifiers/dashboardnotifier.dart';
import 'notifiers/filternotifier.dart';
import 'notifiers/home_notifiers.dart';
import 'notifiers/login_notifier.dart';
import 'notifiers/register_notifier.dart';
import 'notifiers/wishlistnotifier.dart';

void main() {
  runApp(MyApp());
  // runApp(MyApp());
  // runApp(new MaterialApp(
  //   home: new SplashScreen(),
  //   debugShowCheckedModeBanner: false,
  //   routes: <String, WidgetBuilder>{
  //     '/DashBoard': (BuildContext context) => new DashBoard()
  //   },
  // ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiCall().context = context;
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
          create: (context) => HomeTabNotifier(),
        ),
          ChangeNotifierProvider(
            create: (context) => LoginLoadingNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterLoadingNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => DocsAddedNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartUpdatedNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterUpdatedNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => DashBoardUpdateNotifier(),
          ),

          ChangeNotifierProvider(
            create: (context) => WishListUpdatedNotifier(),
          ),

          ChangeNotifierProvider(
              create: (context) => OTPNotifier()
          )
        ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nazarath',
        theme:  ThemeData(
          primaryColor: colorPrimary,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.white
          ),
          fontFamily: 'Roboto',
          // primarySwatch: colorPrimary,
          visualDensity: VisualDensity.standard,
        ),
        home: SplashScreen(),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}
