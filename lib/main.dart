import 'package:flutter/material.dart';
import 'file:///D:/0Likhin/nazarath_app/lib/Screens/DashBoard.dart';
import 'file:///D:/0Likhin/nazarath_app/lib/Screens/DashBoard.dart';
import 'file:///D:/0Likhin/nazarath_app/lib/Screens/Splash.dart';



void main() {
  runApp(MyApp());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(),

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
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(

      ),

    );
  }
}
