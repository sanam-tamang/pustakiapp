// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    Key? key,
    required this.tag,
    required this.child,
  }) : super(key: key);
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent, child: Hero(tag: tag, child: child));
  }
}
