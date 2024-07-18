import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loyadhamsatsang/Constants/app_colors.dart';

class CustomTextFieldWithPrefixIcon extends StatefulWidget {
  String hintname;
  TextEditingController ?controller;
  TextInputType? keyboardType;
  bool? readOnly;
  Widget? prefixIcon;
  Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
CustomTextFieldWithPrefixIcon({
    Key? key,
    required this.hintname,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextFieldWithPrefixIcon> createState() => _CustomTextFieldWithPrefixIconState();
}

class _CustomTextFieldWithPrefixIconState extends State<CustomTextFieldWithPrefixIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 15, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.apptheme),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        readOnly: widget.readOnly??false,
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon??SizedBox.shrink(),
          //contentPadding:  EdgeInsets.only(left: 13, top: 18, bottom: 18),
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
