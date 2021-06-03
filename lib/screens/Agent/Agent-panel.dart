import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/user.dart';

import 'package:CTAMA/screens/screens.dart';
import 'package:CTAMA/widgets/Agent-widget.dart';

import 'package:flutter/material.dart';

class Agent extends StatefulWidget {
  const Agent({
    Key key,
  }) : super(key: key);
  @override
  _AgentState createState() => _AgentState();
}

class _AgentState extends State<Agent> {
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
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: Text(name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Panneau d'agent"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
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
      body: Agentpage1(),
    );
  }
}
