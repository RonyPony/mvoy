import 'package:flutter/material.dart';
import 'package:mvoy/widgets/colors.dart';

// ignore: must_be_immutable
class MapTextField extends StatelessWidget {
   TextEditingController controller;
     FocusNode focusNode;
     String label;
     String hint;
     double width;
     Widget prefixIcon;
    Widget? suffixIcon;
     Function(String) locationCallback;
   MapTextField ({super.key, 
  required this.controller, 
  required this.focusNode, 
  required this.hint, 
  required this.label,
  required this.locationCallback,
  required this.prefixIcon,
  required this.suffixIcon,
   required this.width });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        
        focusNode: focusNode,
        decoration: new InputDecoration(
          
          focusColor: Colors.black,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }
}