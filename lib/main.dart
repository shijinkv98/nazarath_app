import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/notifiers/cartnotifier.dart';
import 'package:nazarath_app/notifiers/dataupdatenotifier.dart';
import 'package:nazarath_app/screens/Splash.dart';
import 'package:nazarath_app/screens/language_constants.dart';
import 'package:nazarath_app/screens/register/otp.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'helper/constants.dart';
import 'language_localization.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });

      },
      onResume: (message) async{
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });

      },
    );
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

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
            create: (context) => DataUpdateNotifier(),
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
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "SA"),
        ],
        localizationsDelegates: [
          LanguageLocalization.delegate,
          LanguageLocalization.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
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
