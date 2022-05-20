import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback? onpressed;
  final VoidCallback? onlong;
  final double radius;
  final double height;
  final double fontsize;
  final Color color;
  const CustomButton(
      {required this.text,
      this.height = 10,
      this.width = 400,
      this.color = Colors.white,
      this.fontsize = 18,
      this.onlong,
      this.onpressed,
      this.radius = 10,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: onlong,
      height: height,
      minWidth: width,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color,
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontsize),
      ),
    );
  }
}
