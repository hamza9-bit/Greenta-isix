import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agent/rapports.dart';
import 'package:CTAMA/screens/SinistreScreen.dart';
import 'package:CTAMA/screens/agr-sinsitres.dart';
import 'package:CTAMA/screens/agri-parcelle.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/screens/saved_parcelle_ag.dart';
import 'package:flutter/material.dart';

import 'Saved_Parcelle.dart';

class Agriculteurwidget extends StatefulWidget {
  final String id;

  final Myuser myuser;

  const Agriculteurwidget({Key key, this.id, this.myuser}) : super(key: key);

  @override
  _AgriculteurwidgetState createState() => _AgriculteurwidgetState();
}

class _AgriculteurwidgetState extends State<Agriculteurwidget> {
  int _currentIndex = 0;

  Widget _buildsinglecontainer(
      {IconData icon, String name, BuildContext context}) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 70,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedParcelleag(
                              uid: widget.myuser.id,
                            )));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.agriculture_rounded,
                name: "Parcelles",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgriSinistre(
                              cin: widget.myuser.cin,
                              iamAgri: true,
                              nbsin: widget.myuser.nbSinisitre,
                              readOnly: true,
                              uid: widget.myuser.id,
                            )));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.dangerous,
                name: "Sinistres",
              ),
            ),
            RaisedButton(
              onPressed: () async {
                AuthenticationService().signOut().then((value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (cntx) => LoginScreen()),
                        (route) => false);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
