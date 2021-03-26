import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
double _height=_randomContainer.nextInt(100).toDouble();
double _width=_randomContainer.nextInt(100).toDouble() ;
BorderRadiusGeometry _border = BorderRadius.circular(20) ;
Random _randomContainer = new Random ();
class animation extends StatefulWidget {
  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration : Duration( seconds: 3)  ,
          height: _height ,
          width:  _width,
           decoration: BoxDecoration(
             borderRadius: _border,
             color: Color.fromRGBO(_randomContainer.nextInt(256),_randomContainer.nextInt(256), _randomContainer.nextInt(256), 1),
           ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(  Icons.play_arrow),
  onPressed: (){

          setState( () {
            _height= _randomContainer.nextInt(400).toDouble() ;
            _width= _randomContainer.nextInt(200).toDouble() ;
            decoration: BoxDecoration(
            borderRadius: _border,
            color: Color.fromRGBO(_randomContainer.nextInt(256),_randomContainer.nextInt(256), _randomContainer.nextInt(256), 1),
          );

  }
          );
        }
      ),
    );



  }
}
