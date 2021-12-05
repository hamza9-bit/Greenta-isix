import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login-screen.dart';

class Affectation extends StatelessWidget {
  Future<bool> createDialog1(BuildContext context, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir supprimer cette parcelle?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () async {
                  await DatabaseService().deleteNOAparcelle(id);

                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Oui",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("PARCELLES"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (cntx) => LoginScreen()),
                  (route) => false);
              print("PERFORM ADMIN DECONNECTION");
            },
            label: Text(
              'Déconnexion',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseService().getNoAffectedParcelle(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelle ajoutée.",
                    style: TextStyle(fontSize: 23)),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final MyPpolygon myPpolygon =
                    MyPpolygon.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) => AgrProfile(
                              uid: myPpolygon.uid,
                            ))),
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.delete_forever_rounded),
                              color: Colors.red,
                              onPressed: () =>
                                  createDialog1(context, myPpolygon.id),
                            ),
                            title: Row(
                              children: <Widget>[
                                PPWS(uid: myPpolygon.uid),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Parcelle n°$index",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Non affecteé",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 17),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PPWS extends StatelessWidget {
  const PPWS({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().profileList.doc(uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60 / 2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/pa.jpg'),
              ),
            ),
          );
        }
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(60 / 2),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
