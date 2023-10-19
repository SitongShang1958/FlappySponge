// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;
  
  MyBarrier(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/images/jellyfish.png'), repeat: ImageRepeat.repeat),
        border: Border.all(width: 10, color: Colors.pink.shade200),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
