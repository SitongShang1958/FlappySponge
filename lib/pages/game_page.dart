// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_maomao/barrier.dart';
import 'package:mini_maomao/button.dart';
import 'package:mini_maomao/sponge.dart';

class GamePage extends StatefulWidget {

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GlobalKey containerKey = GlobalKey();
  static int score = 0;
  static int bestScore = 0;
  static double ttYaxis = 0;
  double time = 0;
  double initialHeight = ttYaxis;
  double height = 0;
  bool gameStarted = false;
  bool gameOver = false;
  int passScore = 17;
  static double barrierXOne = 0;
  double barrierXTwo = barrierXOne + 1.5;
  double barrierHeightOne_1 = 200;
  double barrierHeightOne_2 = 200;
  double barrierHeightTwo_1 = 250;
  double barrierHeightTwo_2 = 150;

  void jump() {
    if (!gameOver) {
      setState(() {
        time = 0;
        initialHeight = ttYaxis;
      });
    }
  }

  double absToRelativeX(double absX) {
    double containerWidth = MediaQuery.of(context).size.width;
    //print(containerWidth);
    return 2 * absX / containerWidth;
  }
 
  double absToRelativeY(double absY) {
    RenderBox renderBox = containerKey.currentContext?.findRenderObject() as RenderBox;
    double containerHeight = renderBox.size.height;
    
    return - 2 * absY / containerHeight;
  }

  double relativeToAbsY(double relativeY) {
    RenderBox renderBox = containerKey.currentContext?.findRenderObject() as RenderBox;
    double containerHeight = renderBox.size.height;
    return - relativeY * containerHeight / 2;
  }

  void checkTouchesBarrier() {
    double eighty = absToRelativeX(80);
    double characterTopY = ttYaxis + absToRelativeY(30);
    double characterBottomY = ttYaxis - absToRelativeY(30);
    double barrierOneBottomY = -1 - absToRelativeY(barrierHeightOne_1);
    double barrierOneTopY = 1 + absToRelativeY(barrierHeightOne_2);

    double barrierTwoBottomY = -1 - absToRelativeY(barrierHeightTwo_1);
    double barrierTwoTopY = 1 + absToRelativeY(barrierHeightTwo_2);

    if (barrierXOne > 0 - eighty && barrierXOne < 0 + eighty) {
      if (characterTopY < barrierOneBottomY || characterBottomY > barrierOneTopY) {
        setState(() {
          gameOver=true;
          bestScore = max(bestScore, score);
        });
      }
    } else if (barrierXTwo > 0 - eighty && barrierXTwo < 0 + eighty) {
      if (characterTopY < barrierTwoBottomY || characterBottomY > barrierTwoTopY) {
        setState(() {
          gameOver=true;
          bestScore = max(bestScore, score);
        });
      }
    }
  }


  restartGame() {
    setState(() {
      gameStarted = false;
      gameOver = false;
      score = 0;
      time = 0;
      ttYaxis = 0;
      initialHeight = ttYaxis;
      height = 0;
      barrierXOne = 0;
      barrierXTwo = barrierXOne + 1.5;
    });
  }


  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) { 
      time += 0.05;
      height = -4.9 * time * time + 1.8 * time;
      setState(() {
        ttYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
          double rand = 2 * Random().nextDouble() - 1; //(-1,1)
          double vary = 80 * rand;
          RenderBox renderBox = containerKey.currentContext?.findRenderObject() as RenderBox;
          double containerHeight = renderBox.size.height;
          while(barrierHeightOne_1+vary > containerHeight || barrierHeightOne_1+vary < 0
          || barrierHeightOne_2-vary > containerHeight || barrierHeightOne_2-vary < 0) {
            rand = 2 * Random().nextDouble() - 1; //(-1,1)
            vary = 80 * rand;
          }
          setState(() {
            barrierHeightOne_1 = barrierHeightOne_1 + vary;
            barrierHeightOne_2 = barrierHeightOne_2 - vary;
          });

          score += 1;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;

          double rand = 2 * Random().nextDouble() - 1; //(-1,1)
          double vary = 80 * rand;
          RenderBox renderBox = containerKey.currentContext?.findRenderObject() as RenderBox;
          double containerHeight = renderBox.size.height;
          while(barrierHeightTwo_1+vary > containerHeight || barrierHeightTwo_1+vary < 0
          || barrierHeightTwo_2-vary > containerHeight || barrierHeightTwo_2-vary < 0) {
            rand = 2 * Random().nextDouble() - 1; //(-1,1)
            vary = 80 * rand;
          }
          setState(() {
            barrierHeightTwo_1 = barrierHeightTwo_1 + vary;
            barrierHeightTwo_2 = barrierHeightTwo_2 - vary;
          });

          score += 1;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (ttYaxis > 1) {
        timer.cancel();
        gameStarted = false;
        gameOver = true;
        bestScore = max(bestScore, score);
      }

      checkTouchesBarrier();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15,),
                      Text('SCORE', style: GoogleFonts.pressStart2p(color: Colors.blue.shade400, fontSize: 18),),
                      SizedBox(height: 5,),
                      Text(score.toString(), style: GoogleFonts.pressStart2p(color: Colors.blue.shade400, fontSize: 35),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15,),
                      Text('BEST SCORE', style: GoogleFonts.pressStart2p(color: Colors.blue.shade400, fontSize: 18),),
                      SizedBox(height: 5,),
                      Text(bestScore.toString(), style: GoogleFonts.pressStart2p(color: Colors.blue.shade400, fontSize: 35),)
                    ],
                  )
                ],
              )
            ) 
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                if (gameStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    key: containerKey,
                    alignment: Alignment(0,ttYaxis),
                    duration: Duration(milliseconds: 0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/sea-floor.png'),
                        fit: BoxFit.cover
                      ),
                    ),
                    child: MySponge(),
                  ),
                  Container(
                    alignment: Alignment(0,-0.3),
                    child: gameStarted
                      ? Text('')
                      : Text('T A P  T O  P L A Y', style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne,-1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(barrierHeightOne_1)
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne,1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(barrierHeightOne_2)
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo,-1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(barrierHeightTwo_1)
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo,1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(barrierHeightTwo_2)
                  ),
                  Container(
                    alignment: Alignment(0,0.1),
                    child: Visibility(
                      visible: gameOver,
                      child: Container(
                        width: 250,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black54, width: 3)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height:50),
                            Text(
                              'Game Over',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 13,),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                CustomButton('Restart', Colors.green, restartGame),
                                SizedBox(width: 20),
                                CustomButton('Exit', Colors.red, () {Navigator.pushNamed(context, '/animation_page');}),
                              ],
                            ),
                          ],
                          
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,0.1),
                    child: Visibility(
                      visible: score >= passScore,
                      child: Container(
                        width: 250,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.pink.shade300, width: 3)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height:20),
                            Text(
                              'You win',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/animation_page');
                              },
                              child: Lottie.asset(
                                'lib/gifs/fox.json', 
                                width: 100,
                                height: 100,
                                repeat: true,
                                animate: true,
                              ),
                            ),
                          ],
                          
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          Container(height: 15, color: Color.fromARGB(255, 192, 137, 27)),
        ],
      )
    );
  }
}