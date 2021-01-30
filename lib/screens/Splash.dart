import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nazarath_app/Screens/register/register.dart';

import '../helper/constants.dart';
import '../network/ApiCall.dart';
import 'DashBoard.dart';
import 'home.dart';
import 'login.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 3),
          () => ApiCall().getUserToken().then((token) => {
        if (token != null &&
            token.trim().isNotEmpty)
          {
            // Navigator.of(context).pushReplacementNamed('/home')
            Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashBoard()),
                )
          }
        else
          { Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          )}
      }),
      // () => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginScreen()),
      //     )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [colorPrimary, gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Image(
              image: AssetImage('assets/icons/nazarath_logo.png'),
              height: 40.0,
              fit: BoxFit.contain,
            ),
          )),
    );
  }
}
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 3), () {
//       ApiCall().getUserToken().then((token) => {
//         if (token != null && token.trim().isNotEmpty)
//           {
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => DashBoard()),)
//           }
//         else
//           {
//         Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Login()),)}
//       });
//
//       // Navigator.of(context)
//       //     .pushReplacementNamed("mapPlacePicker", arguments: null);
//     });
//     return Scaffold(
//       body: Container(
//         color: colorPrimary,
//         child: Center(
//           child: Image.asset(
//             'assets/icons/nazarath_logo.png',
//             height: 80,
//             // cacheHeight: 60,
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//       ),
//     );
//   }
//
// }