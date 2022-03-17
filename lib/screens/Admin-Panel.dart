import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  initState() {
    super.initState();
  }

  final DatabaseService databaseService = DatabaseService();

  /*Future<bool> createDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir supprimer cet utilisateur?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () {
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

  Future<bool> createDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir accpeter cet utilisateur?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () {
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
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("Panneau d'admin"),
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
        stream: databaseService.getNoAcceptedUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.length > 0) {
              final List<QueryDocumentSnapshot> list = snapshot.data.docs;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                    children: List.generate(list.length, (index) {
                  return card1(Myuser.fromMap(list[index].data()));
                })),
              );
            }

            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: height / 3),
                child: Column(
                  children: [
                    Text(
                      "AUCUNE DEMANDE DE LOGIN POUR ",
                      style: TextStyle(fontSize: width / 20),
                    ),
                    Text(
                      "LE MOMENT",
                      style: TextStyle(fontSize: width / 20),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  /*Widget getCard(Myuser myuser) {
    return ListTile(
      trailing: Container(
        alignment: Alignment.centerLeft,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.done_outline_outlined),
              color: Colors.green,
              onPressed: () async {
                createDialog1(context).then((value) async {
                  if (value != null) {
                    if (value) {
                      await databaseService.setAcceptedT(myuser.id);
                    }
                  }
                });
              },
            ),
            IconButton(
                icon: Icon(Icons.delete_forever_rounded),
                color: Colors.red,
                onPressed:
                    () {} /*async {
                createDialog(context).then((value) async {
                  if (value != null) {
                    if (value) {
                      await DatabaseService()
                          .profileList
                          .doc(myuser.id)
                          .delete();
                    }
                  }
                });
              },*/
                ),
          ],
        ),
      ),
      title: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60 / 2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  myuser.role == 1
                      ? "assets/images/agent.png"
                      : myuser.role == 2
                          ? "assets/images/exp.png"
                          : "assets/images/agri.png",
                ),
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
                myuser.email,
                style: TextStyle(fontSize: 15),
                softWrap: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    myuser.cin,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    child: Text(
                        myuser.role == 1
                            ? "Agent"
                            : myuser.role == 2
                                ? "Expert"
                                : "Agriculteur",
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}*/
  Future<bool> createDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir supprimer cet utilisateur?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () {
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

  Future<bool> createDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir accpeter cet utilisateur?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () {
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

  Widget card1(Myuser myuser) {
    return Card(
      child: Container(
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage(
                        myuser.role == 1
                            ? "assets/images/exp.png"
                            : "assets/images/agri.png",
                      ),
                    )),
              ),
              Flexible(
                flex: 6,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myuser.email,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            softWrap: true),
                        RichText(
                          softWrap: true,
                          text: TextSpan(children: [
                            TextSpan(
                                text: myuser.cin,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            TextSpan(
                                text: myuser.role == 1
                                    ? "  Agent"
                                    : myuser.role == 2
                                        ? "  Expert"
                                        : "  Agriculteur",
                                style: TextStyle(
                                    color: Colors.blue[900], fontSize: 14)),
                          ]),
                        ),
                      ],
                    )),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: InkWell(
                            child: IconButton(
                              icon: Icon(Icons.done_outline_outlined),
                              color: Colors.green,
                              onPressed: () async {
                                createDialog1(context).then((value) async {
                                  if (value != null) {
                                    if (value) {
                                      await databaseService
                                          .setAcceptedT(myuser.id);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.delete_forever_rounded),
                            color: Colors.red,
                            onPressed: () async {
                              createDialog(context).then((value) async {
                                if (value != null) {
                                  if (value) {
                                    await DatabaseService()
                                        .profileList
                                        .doc(myuser.id)
                                        .delete();
                                  }
                                }
                              });
                            },
                          ),
                          /*onDelete?.call(),*/
                        ),
                      ]),
                ),
              ),
            ]),
      ),
    );
  }
}
