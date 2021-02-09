import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:spinner_input/spinner_input.dart';

class SpinnerProduct extends StatefulWidget {
  @override
  _SpinnerProductState createState() => _SpinnerProductState();
}

double spinner_product = 1;
class _SpinnerProductState extends State<SpinnerProduct> {



  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
        Container(
                padding:EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2) ,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5, color:item_text_gray_light),
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(0.0)),
                ),
                child: SpinnerInput(
                  minValue: 1,
                  maxValue: 200,
                  spinnerValue: spinner_product,
                  step: 1,
                  disabledLongPress: true,
                  disabledPopup: true,
                  middleNumberStyle: TextStyle(fontSize: 12),
                  middleNumberBackground: Colors.white,
                  plusButton: SpinnerButtonStyle(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      textColor: Colors.black,

                      elevation: 0
                  ),
                  minusButton: SpinnerButtonStyle(elevation: 0,
                    color: Colors.white, borderRadius: BorderRadius.circular(0),
                    textColor: Colors.black,

                  ),
                  onChange: (newValue) {
                    setState(() {
                      spinner_product = newValue;
                    });

                    },
                ),
              ),
      ],
    );

  }
}