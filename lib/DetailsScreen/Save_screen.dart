import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Save Build'),
          backgroundColor: Colors.black87,
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15),
                child: InkResponse(
                  child: Icon(
                    Icons.save,
                  ),
                  onTap: () {},
                ))
          ]),
      body: Container(
        color: Colors.grey.shade800
      ),
    );
  }
}
