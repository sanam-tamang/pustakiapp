import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    elevation: 4,
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
  ));
}
