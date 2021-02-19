import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';

import '../DashBoard.dart';
import '../notification.dart';

class NotificationBadge  extends StatefulWidget {
  String slug, store;
  int count;
  Widget superWidget;
  ValueNotifier<int> notifer;
  NotificationBadge( ValueNotifier<int> notifer)
  {

    this.notifer=notifer;
  }

  @override
  _NotificationBadgeState createState() => _NotificationBadgeState(notifer: this.notifer);
}


class _NotificationBadgeState extends State<NotificationBadge> {
  ValueNotifier<int> notifer ;

  _NotificationBadgeState({this.notifer});
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen("notification")),
          );
        },
        child: Container(
          width: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(AssetImage("assets/icons/notification.png"),),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  child: Text(notificationCounterValueNotifer.value.toString()),
                ),
              )
            ],
          ),
        ),
      );


  }

}
