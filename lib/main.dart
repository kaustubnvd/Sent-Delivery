import "package:flutter/material.dart";

void main() => runApp(SentApp());

class SentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SentAppState();
  }
}

class _SentAppState extends State<SentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sent"),
        ),
      ),
    );
  }
}
