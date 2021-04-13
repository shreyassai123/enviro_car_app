import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Map<dynamic, dynamic> userInfo;

  const HomePage({this.userInfo});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Text(widget.userInfo["name"], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text(widget.userInfo["mail"], style: TextStyle(fontSize: 15),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
