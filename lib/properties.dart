import 'package:flutter/material.dart';

class ConstHeight extends StatelessWidget {
  const ConstHeight({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class ConstWidth extends StatelessWidget {
  const ConstWidth({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width,
    );
  }
}
