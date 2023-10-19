// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class AnimationPage extends StatefulWidget {


  @override
  State<AnimationPage> createState() =>  AnimationPageState();
}

class  AnimationPageState extends State<AnimationPage> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
              setState(() {
                visible = false;
              });
              Navigator.pushNamed(context, '/game_page');
            },
      child: Scaffold(
        body: Center(
            child: Visibility(
              visible: visible,
              child: Column(
                children: [
                  SizedBox(height: 250,),
                  Lottie.asset(
                    'lib/gifs/sea.json', 
                    width: 200,
                    height: 200,
                    repeat: true,
                    animate: true,
                  ),
                  SizedBox(height: 40,),
                  Text(
                    'Mr. Sponge',
                    style: GoogleFonts.pressStart2p(color: Colors.yellow.shade600, fontSize: 24),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Does NOT Like',
                    style: GoogleFonts.pressStart2p(color: Colors.blue.shade400, fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Jellyfish',
                    style: GoogleFonts.pressStart2p(color: Colors.purple.shade400, fontSize: 20),
                  )
                ],
              )
            ),
          )     
        ),
    );
  }
}