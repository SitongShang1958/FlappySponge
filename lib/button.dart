// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  CustomButton(this.text, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: color, // Choose a Pokémon-style color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black54, width: 2),
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'PokemonFont', // Use a Pokémon-style font
            ),
          ),
        ),
      ),
    );
  }
}