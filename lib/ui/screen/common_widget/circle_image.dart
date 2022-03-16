import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleImage extends StatelessWidget {
  final String url;
  final double radius;

  const CircleImage({Key? key, required this.url, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CircleAvatar(backgroundImage: NetworkImage(url), radius: radius);
}
