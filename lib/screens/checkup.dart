import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/updateresponse.dart';

TextEditingController _dateController = TextEditingController();
TextEditingController _timeController = TextEditingController();
TextEditingController _locationController = TextEditingController();
String _setTime, _setDate;
class CheckUpScreen extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _CheckUpScreenState createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<CheckUpScreen> {
  double _height;
  double _width;
  PickResult selectedPlace;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  final GlobalKey<FormState> _checkUpForms = GlobalKey<FormState>();
  String selected_date="2021-01-01";
  String selected_Time="00:00:00";
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            Column(
              children: [
                getTopContainer(),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 22, right: 22),
                    child: Form(
                      key: _checkUpForms,
                      child: Column(
                        children: [
                          mobileNumberField(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: addressField(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: InkWell(
                      onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return
                                PlacePicker(
                                apiKey: 'AIzaSyAIjaTpHNWTYXsHI-aW1kNxGQVXc3_epGA'.trim(),
                                initialPosition: CheckUpScreen.kInitialPosition,
                                useCurrentLocation: true,
                                selectInitialPosition: true,

                                //usePlaceDetailSearch: true,
                                onPlacePicked: (result) {
                                  selectedPlace = result;
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _locationController.text=selectedPlace == null ?"":selectedPlace.formattedAddress ?? "";

                                  });
                                },

                              );
                            },
                          ),
                        );
                      },
                      child: locationField()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: dateField()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: timeField()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 22, right: 22,bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      color: colorPrimary,
                      elevation: 0,
                      child: Text('Book an Appointment',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      onPressed: () async {
                        if (_checkUpForms.currentState.validate()) {
                          _checkUpForms.currentState.save();
                            selected_date=selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+
                                selectedDate.day.toString();
                            String hr=selectedTime.hour<12?"0"+selectedTime.hour.toString():selectedTime.hour.toString();
                            String mt=selectedTime.minute<10?"0"+selectedTime.minute.toString():selectedTime.minute.toString();
                            selected_Time=hr+":"+mt+":00";
                            String lat=selectedPlace.geometry.location.lat.toString();
                          String lng=selectedPlace.geometry.location.lng.toString();
                          checkup(mobileNmber, address, selectedPlace.formattedAddress, selected_date, selected_Time, "message", lat, lng);

                        }
                      }
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
  String date;
  Widget dateField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    enabled: false,
    controller: _dateController,
    onSaved: (String val) {
      _setDate = val;
    },
    // style: style,
    validator: (value) {
      if (value.trim().isEmpty) {
        return Languages.of(context).thisFieldRequired;
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
      hintText: Languages.of(context).date, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).dateCaps,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),

      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/calendar.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );

  Future<String>checkup(String phone,
      String adrs,String loc,String date,String time,String msg,String lat,String log) async {

    Map body = {
      "phone":phone,
      "address":address,
      "location":loc,
      "date":date,
      "time":time,
      "message":msg,
      "latitude":lat,
      "longitude":log
    };
    ApiCall()
        .execute<UpdateResponse, Null>("appointment/store/"+selectLanguage, body).then((result) {
      ApiCall().showToast(result.message);
    });

    return "Success!";
  }
  String mobileNmber;
  Widget mobileNumberField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      mobileNmber = value;
    },
    // style: style,
    validator: (value) {
      if (value.trim().isEmpty) {
        return Languages.of(context).thisFieldRequired;
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.phone,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
      hintText: Languages.of(context).phoneNumber, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).phoneNumberCaps,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),

      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/mobile.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );
  String address;
  Widget addressField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onChanged: (value) {
      address = value;
    },
    // style: style,
    validator: (value) {
      if (value.trim().isEmpty) {
        return Languages.of(context).thisFieldRequired;
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
      hintText: Languages.of(context).address, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).addressCaps,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),

      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/home.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );
  String location;
  Widget    locationField() => TextFormField(
    cursorColor: colorPrimary,
    controller: _locationController,
    obscureText: false,
    enabled: false,
    onChanged: (value) {
      location = value;
    },
    // style: style,
    validator: (value) {
      if (value.trim().isEmpty) {
        return Languages.of(context).thisFieldRequired;
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
      hintText: Languages.of(context).location, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).locationCaps,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),

      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/location.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );
  String time;
  Widget timeField() => TextFormField(
    cursorColor: colorPrimary,
    obscureText: false,
    onSaved: (String val) {
      _setTime = val;
    },
    enabled: false,
    // style: style,
    validator: (value) {
      if (value.trim().isEmpty) {
        return Languages.of(context).thisFieldRequired;
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.name,
    controller: _timeController,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
      hintText: Languages.of(context).time, hintStyle: TextStyle(color: textColorSecondary),
      labelText: Languages.of(context).timeCaps,
      labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorPrimary),
      ),

      prefixIcon: new IconButton(
        icon: new Image.asset(
          'assets/icons/time.png',
          width: register_icon_size,
          height: register_icon_size,
        ),
        onPressed: null,
        color: colorPrimary,
      ),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
  );

  Widget getTopContainer() {
    return Container(
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
            height: 10,
          ),
          Center(
            child: Text(
              Languages.of(context).howItWorks,
              style: TextStyle(
                  color: text_tilte_page,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

}



