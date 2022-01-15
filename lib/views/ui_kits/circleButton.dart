import 'package:flutter/material.dart';

class circleButton extends StatelessWidget {
  circleButton({required this.icon, required this.backgroundColor});
  Icon icon = Icon(Icons.ac_unit);
  Color backgroundColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // border color
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: icon,
      ),
    );
  }
}
