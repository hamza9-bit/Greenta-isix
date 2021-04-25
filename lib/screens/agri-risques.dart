import 'dart:io';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/Risque.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AgriRisques extends StatefulWidget {

  AgriRisques({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _AgriRisquesState createState() => _AgriRisquesState();
}

class _AgriRisquesState extends State<AgriRisques> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Risques Info"),
      ),
      body: FutureBuilder(
        future: DatabaseService().getRisqueByuid(widget.uid),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData){

            final Risque risque = Risque.fromMap(snapshot.data.data());

        print(risque);

         return Container(
        width: double.infinity,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("question 1 : ${getResponsefromBoolean(risque.ans1)}"),
            Text("question 2 : ${risque.ans2}"),
            Text("question 3 : ${risque.ans3}"),
            Text("question 4 : ${risque.ans4}"),
            Text("question 5 : ${risque.ans5}"),
            Text("question 6 : ${risque.ans6}"),
            Text("question 7 : ${risque.ans7}"),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  String getResponsefromBoolean(bool res){
    return res ? "YES": "NO";
  }
}
