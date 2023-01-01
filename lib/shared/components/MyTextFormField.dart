import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/Colors_Const.dart';

class MyTextFormField extends StatelessWidget {
   MyTextFormField({Key? key,required this.controller,required this.label,required this.type,required this.icon,this.onTap,required this.validator}) : super(key: key);
  var controller;
  String? label;
  var type;
  IconData icon;
  VoidCallback? onTap;
  var validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: SecondColor,
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        validator: validator,
        onTap: onTap,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: MainColor,),
            labelStyle: TextStyle(color: Colors.grey[400]),
            labelText: label,
            border: OutlineInputBorder()
        ),
      ),
    );
  }
}
