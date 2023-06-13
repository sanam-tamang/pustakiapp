// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key? key,
    this.circularColor = Colors.white,
    this.prefixText,
  }) : super(key: key);
  final Color? circularColor;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(prefixText ?? ''),
            SizedBox(
              width: prefixText == null ? 0 : 5,
            ),
            CircularProgressIndicator(
              color: circularColor,
              strokeWidth: 3,
            ),
          ],
        ));
  }
}
