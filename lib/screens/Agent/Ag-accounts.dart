import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgAgriculteurs extends StatefulWidget {
  @override
  _AgAgriculteursState createState() => _AgAgriculteursState();
}

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

class _AgAgriculteursState extends State<AgAgriculteurs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Text("Agriculteurs"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder(
      stream: DatabaseService().getAgriculteurs(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data.docs.isEmpty) {
            return Center(
              child: Text("PAS ENCORE D'AGRICULTEURS.",
                  style: TextStyle(fontSize: 23)),
            );
          } else {
            final List<QueryDocumentSnapshot> query = snapshot.data.docs;

            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: query.length,
                itemBuilder: (context, index) {
                  final Myuser myuser = Myuser.fromMap(query[index].data());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgrProfile(
                                    myuser: myuser,
                                  )));
                    },
                    child: card1(myuser),
                  );
                });
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /* Widget getCard(Myuser myuser) {
    return ListTile(
      trailing: IconButton(
        icon: Icon(Icons.delete_forever_rounded),
        color: Colors.red,
        onPressed: () async {
          createDialog(context).then((value) async {
            if (value != null) {
              if (value) {
                await DatabaseService().profileList.doc(myuser.id).delete();
              }
            }
          });
        },
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
                image: AssetImage(myuser.imageUrl != null
                    ? myuser.imageUrl
                    : "assets/images/agri.png"),
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
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                myuser.cin,
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ],
          )
        ],
      ),
    );
  }
}*/
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
                        "assets/images/agri.png",
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
