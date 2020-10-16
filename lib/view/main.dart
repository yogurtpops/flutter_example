import 'package:example_project/view/nested_listview_bad.dart';
import 'package:example_project/view/state_management_demo.dart';
import 'package:flutter/material.dart';

import 'nested_listview_good.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: ((){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NestedListviewDemo_()
              ));
            }),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Bad nested listview"
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: ((){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NestedListviewDemo()
              ));
            }),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                      "Good nested listview"
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: ((){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ParentWidgetExample()
              ));
            }),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                      "State Management Demo"
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          )

        ],
      )
    );
  }
}
