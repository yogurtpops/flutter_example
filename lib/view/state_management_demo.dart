import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParentWidgetExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateParentWidgetExample();
  }
}

class StateParentWidgetExample extends State<ParentWidgetExample> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      color: Colors.grey,
      child: Stack(
        children: [
          Center(child: ChildWidget1()),
          Positioned(
            bottom: 300,
            left: 150,
            // left: 0,
            // right: 0,
            child: ChildWidget2(),
          )
        ],
      ),
    );
  }
}

class ChildWidget1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateChildWidget1();
  }
}

class StateChildWidget1 extends State<ChildWidget1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }
}

class ChildWidget2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateChildWidget2();
  }
}

class StateChildWidget2 extends State<ChildWidget2> {

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 24,
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Text("Green", style: TextStyle(
              color: Colors.black,
              fontSize: 12
            ),),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            right: 8,
            child: Icon(Icons.check),
          )
        ],
      ),
    );
  }
}