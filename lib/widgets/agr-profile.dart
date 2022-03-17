import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Saved_Parcelle.dart';
import 'package:CTAMA/screens/SinistreScreen.dart';
import 'package:CTAMA/screens/agri-risques.dart';
import 'package:CTAMA/screens/rapport-agri.dart';
import 'package:CTAMA/screens/saved_parcelle_ag.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgrProfile extends StatefulWidget {
  final Myuser myuser;
  final String uid;
  final Mysinistre mysinis;

  const AgrProfile({
    Key key,
    this.myuser,
    this.uid,
    this.mysinis,
  }) : super(key: key);

  @override
  _AgrProfileState createState() => _AgrProfileState();
}

class _AgrProfileState extends State<AgrProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Profil D'agriculteur"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: widget.uid == null
              ? Column(
                  children: [
                    _getHeader(widget.myuser.imageUrl),
                    SizedBox(height: 10),
                    _profilename(widget.myuser.name),
                    SizedBox(height: 30),
                    _heading("Informations personnelles"),
                    SizedBox(height: 6),
                    _detailsCard(widget.myuser.email, widget.myuser.name,
                        widget.myuser.cin),
                    SizedBox(height: 10),
                    _heading("Informations professionelles"),
                    _settingsCard(widget.myuser.id, widget.myuser.nbSinisitre),
                  ],
                )
              : FutureBuilder(
                  future: DatabaseService().getUserFuture(widget.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data.data() == null) {
                        return Center(
                          child: Text("Aucun agriculteur"),
                        );
                      } else {
                        final Myuser myuser =
                            Myuser.fromMap(snapshot.data.data());
                        return Column(
                          children: [
                            _getHeader(myuser.imageUrl),
                            SizedBox(height: 10),
                            _profilename(myuser.name),
                            SizedBox(height: 30),
                            _heading("Informations personnelles"),
                            SizedBox(height: 6),
                            _detailsCard(myuser.email, myuser.name, myuser.cin),
                            SizedBox(height: 10),
                            _heading("Informations professionelles"),
                            _settingsCard(myuser.id, myuser.nbSinisitre),
                          ],
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _profilename(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard(String email, String name, String identity) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text(email),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(name),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text(identity),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsCard(String id, int nbsin) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cntx) => SavedParcelle(
                              uid: id,
                            )));
              },
              child: ListTile(
                leading: Icon(Icons.landscape_outlined),
                title: Text("Parcelle"),
              ),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (cntx) => AgriRisques(
                          uid: id,
                        )));
              },
              child: ListTile(
                leading: Icon(
                  Icons.dangerous,
                ),
                title: Text(
                  "Risques",
                ),
              ),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (cntx) => SinistreView(
                          mysinistre: widget.mysinis,
                          myuser: widget.myuser,
                          uid: id,
                          readOnly: true,
                        )));
              },
              child: ListTile(
                leading: Icon(Icons.dangerous,
                    color: nbsin > 0 ? Colors.red : Colors.grey),
                title: Text(
                  "Sinistre",
                ),
                trailing: Container(
                  child: Text(
                    "$nbsin",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: nbsin > 0 ? Colors.red : Colors.grey),
                ),
              ),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (cntx) => Rapportagri(uid: id)));
                },
                child: ListTile(
                  leading: Icon(Icons.copy_outlined),
                  title: Text("rapports"),
                ))
          ],
        ),
      ),
    );
  }

  Widget _getHeader(String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      imageUrl != null ? imageUrl : "assets/images/agri.png"),
                )),
          ),
        )
      ],
    );
  }
}
