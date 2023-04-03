import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum FieldFor {
  name,
  age,
  height,
  weight,
}

class CustomTextField extends StatelessWidget {
  final TextEditingController cn;
  final String title;
  final IconData icon;
  final TextInputType inputType;
  final FieldFor fieldFor;
  const CustomTextField(
      {super.key,
      required this.cn,
      required this.title,
      required this.icon,
      required this.inputType,
      required this.fieldFor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 7.w),
      child: TextFormField(
        controller: cn,
        keyboardType: inputType,
        validator: validatorLogic,
        decoration: InputDecoration(
          labelText: title,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  String? validatorLogic(value) {
    switch (fieldFor) {
      case FieldFor.name:
        if (value.isEmpty) {
          return 'please enter your name';
        }
        return null;
      case FieldFor.age:
        if (value.isEmpty) {
          return 'please enter your age';
        }
        if (int.parse(value) > 70) {
          return 'Your age above 70 year old, This is not allowed';
        } else if (int.parse(value) < 15) {
          return 'Your age below 16 year old, THis is not allowed';
        }
        return null;
      case FieldFor.height:
        if (value.isEmpty) {
          return 'please enter your height';
        }
        if (double.parse(value) > 180) {
          return 'Your height above 180cm, This is not allowed';
        }
        if (double.parse(value) < 150) {
          return 'Your height below 150cm, This is not allowed';
        }
        return null;
      case FieldFor.weight:
        if (value.isEmpty) {
          return 'please enter your weight';
        }
        if (double.parse(value) > 130) {
          return 'Your weight above 130kg, This is not allowed';
        }
        if (double.parse(value) < 40) {
          return 'Your weight below 40kg, This is not allowed';
        }
        return null;
    }
  }
}
