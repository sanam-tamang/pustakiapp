// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    Key? key,
    this.imageUrl,
    this.radius = 30.0,
  }) : super(key: key);
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: Colors.grey, width: 2);
    return Container(
      height: radius * 2.4,
      width: radius * 2,
      decoration: imageUrl != null
          ? BoxDecoration(
              border: border,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl!)),
              shape: BoxShape.circle)
          : BoxDecoration(
              border: border,
              image: const DecorationImage(
                  fit: BoxFit.contain,
                  
                  image: AssetImage('assets/icons/person.png')),
              shape: BoxShape.circle),
    );
  }
}
