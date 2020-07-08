import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final int index;
  final Image imageValue;

  DisplayImage({this.index,this.imageValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
            onPressed: (){
                          
            },
          ),
          IconButton(
              icon: Icon(Icons.share),
            onPressed: (){

            },
          ),
          IconButton(
              icon: Icon(Icons.redo),
            onPressed: (){

            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Hero(
            tag: 'index$index',
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Card(
                color: Colors.black,
                child: imageValue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
