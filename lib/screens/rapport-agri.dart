import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'rapportDetails.dart';

class Rapportagri extends StatefulWidget {
  final String uid;

  const Rapportagri({Key key, this.uid}) : super(key: key);
  @override
  _RapportagriState createState() => _RapportagriState();
}

class _RapportagriState extends State<Rapportagri> {
  bool isDownload = false;

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Text("Rapports"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder(
      stream: databaseService.getrapports1(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data.docs.isEmpty) {
            return Center(
              child:
                  Text("Non rapports encore.", style: TextStyle(fontSize: 23)),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final Mysinistre myrapport = Mysinistre.fromCheckedMap(
                      snapshot.data.docs[index].data());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Builder(
                                  builder: (cntx) => RapportView(
                                        mysinistre: myrapport,
                                      ))));
                    },
                    child: getCard(myrapport),
                  );
                });
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getCard(Mysinistre myrapport) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(60 / 2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                myrapport.sinisteid,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${myrapport.date.toString().split("@")[1]}",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ],
          )
        ],
      ),
    );
  }
}
