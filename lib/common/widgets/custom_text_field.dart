import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isDescriptionBox = false,
    this.validator,
    this.obsecure = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isDescriptionBox;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        // autofocus: true,
        validator: validator,
        obscureText: obsecure,
        controller: controller,
        maxLines: isDescriptionBox ? 6 : 1,
        maxLength: isDescriptionBox ? 500 : null,
        decoration: InputDecoration(
            hintText: hintText,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
