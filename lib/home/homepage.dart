import 'package:flutter/material.dart';
import 'package:flutter_football/screen/prev/prev_match.dart' as Previous;
import 'package:flutter_football/screen/next/next_match.dart' as Next;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text("Aplikasi Football"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(text: "Previous Match"),
            new Tab(text: "Next Match"),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new Previous.PrevMatch(),
          new Next.NextMatch()
        ],
      )
    );
  }
}