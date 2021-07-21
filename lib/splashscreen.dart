import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:linkopedia/main.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{

  @override
   void initState() {

    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(76, 40, 122, 48)
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: Center(
                            child: Text("Link\nN\nNote",
                                style: TextStyle(
                                    fontFamily: 'AlexBrush-Regular',
                                    fontSize: 35,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
//                                    fontStyle: FontStyle.italic
                                ),

                              textAlign: TextAlign.center,
                            )
                        ),
                      )
                  ),

                  Expanded(
                    flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            CircularProgressIndicator(

                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                  )
                ],
              )
            ],
          ),
      );
  }

}