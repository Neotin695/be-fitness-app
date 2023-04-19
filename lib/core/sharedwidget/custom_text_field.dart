import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum FieldFor {
  name,
  certificateId,
  nationalId,
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
      case FieldFor.nationalId:
        if (value.isEmpty) {
          return 'please enter your age';
        }
        if (value.length != 13) {
          return 'invalide national id!';
        }
        return null;
      case FieldFor.certificateId:
        if (value.isEmpty) {
          return 'please enter your height';
        }

        return null;
    }
  }
}
