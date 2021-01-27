import 'package:custom_paint/routes/curves.dart';
import 'package:custom_paint/routes/polygons.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.red,
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

  int itemSelectedIndex = 0;

  List pageList = [
    PolygonByTrignomentryPage(),
    CurvesPage(),
    CurvesPage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: pageList[itemSelectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.train_outlined), label: "Trignometry Polygons"),
          BottomNavigationBarItem(
              icon: Icon(Icons.circle), label: "Curves land"),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "Nothing")
        ],
        currentIndex: itemSelectedIndex,
        onTap: (index) => setState(() => itemSelectedIndex = index),
      ),
    );
  }
}
