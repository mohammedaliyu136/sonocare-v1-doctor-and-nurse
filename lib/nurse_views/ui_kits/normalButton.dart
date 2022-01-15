import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:flutter/material.dart';

class normalButton extends StatelessWidget {
  normalButton({ required this.button_text, required this.fontSize,  required this.primaryColor, required this.backgroundColor, required this.onTap});
  String button_text='TEST';
  double fontSize = 0.0;
  Color primaryColor = Colors.white;
  Color backgroundColor = Colors.teal;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(button_text==''?button_text:button_text, style: TextStyle(fontSize: fontSize==0.0?20:fontSize),),
      ),
      style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize:
          MaterialStateProperty.all(Size(double.infinity, 44)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
          ),
          backgroundColor:
          MaterialStateProperty.all(ColorResources.COLOR_PURPLE_MID),
          foregroundColor: MaterialStateProperty.all(ColorResources.COLOR_WHITE),
      ),
    );
  }
}
