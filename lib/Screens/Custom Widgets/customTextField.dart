import 'package:flutter/material.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  String hintname;
  CustomTextField({
    Key? key,
    required this.hintname,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 15, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.apptheme),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15.0, bottom: 10.0),
          hintText: widget.hintname,
          hintStyle: TextStyle(color: Color.fromARGB(255, 54, 73, 102)),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
