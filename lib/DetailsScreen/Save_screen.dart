import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    String value = "";

    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
            centerTitle: true,
            title: Text('Save Build'),
            backgroundColor: Colors.black,
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
        body: DefaultTextStyle(
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Name",
                          border: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white))),
                      maxLength: 25,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w900),
                      onChanged: (text) {
                        value = text;
                      },
                    ))
              ],
            )));
  }
}
