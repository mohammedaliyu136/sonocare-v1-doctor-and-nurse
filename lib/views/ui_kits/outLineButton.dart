import 'package:doctor_v2/utill/color_resources.dart';
import 'package:flutter/material.dart';

class outLineButton extends StatelessWidget {
  outLineButton({ required String this.button_text,  required this.fontSize,  required this.primaryColor, required this.backgroundColor, required this.onTap});
  String button_text='TEST';
  double fontSize = 0.0;
  Color primaryColor = Colors.white;
  Color backgroundColor = Colors.teal;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
              button_text==''?button_text:button_text,
              style: TextStyle(fontSize: 16)
          ),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
            foregroundColor: MaterialStateProperty.all<Color>(ColorResources.COLOR_WHITE),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: ColorResources.COLOR_WHITE)
                )
            )
        ),
        onPressed: onTap
    );
  }
}
