import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nazarath_app/helper/constants.dart';

TextEditingController _dateController = TextEditingController();
TextEditingController _timeController = TextEditingController();
String _setTime, _setDate;

class CheckUpScreen extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<CheckUpScreen> {
  double _height;
  double _width;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

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
                    child: Column(
                      children: [
                        mobileNumberField,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: addressField,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: locationField,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: dateField),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
                  child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: timeField),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      color: colorPrimary,
                      elevation: 0,
                      child: Text('Book an Appoinment',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}

String date;
final dateField = TextFormField(
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
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Date", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'DATE',
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

Container getCheckUp(BuildContext context) {
  return Container(
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          getTopContainer(),
          getForms(context),
        ],
      ),
    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);
}

Widget getForms(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: mobileNumberField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: addressField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: locationField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(child: dateField),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: timeField,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                color: colorPrimary,
                elevation: 0,
                child: Text('Book an Appoinment',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
                onPressed: () {
                  },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String mobileNmber;
final mobileNumberField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    mobileNmber = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Mobile Number", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'MOBILE NUMBER',
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
final addressField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    address = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Address", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'ADDRESS',
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
final locationField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (value) {
    location = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Location", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'LOCATION',
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
final timeField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  onSaved: (String val) {
    _setTime = val;
  },
  enabled: false,
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.name,
  controller: _timeController,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Time", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'TIME',
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

Container getTopContainer() {
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
            "How it works",
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
