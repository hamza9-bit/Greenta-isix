import 'dart:async';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/aide.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/sinistre.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:flutter/material.dart';
import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'agriculteur-widget.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.id, this.myuser}) : super(key: key);
  final String id;
  final Myuser myuser;
  String getResponsefromuser() {
    final AuthenticationService authenticationService = AuthenticationService();
    final User user = authenticationService.getCurrentUser();
    return user != null ? "DECONNEXION" : "SE CONNECTER";
  }

  IconData geticonfromuser() {
    final AuthenticationService authenticationService = AuthenticationService();
    final User user = authenticationService.getCurrentUser();
    return user != null ? Icons.logout : Icons.login;
  }

  void getauthfromuser(BuildContext context) async {
    final AuthenticationService authenticationService = AuthenticationService();
    final User user = authenticationService.getCurrentUser();
    if (user == null) {
      AuthenticationService().signOut().then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (cntx) => LoginScreen()),
              (route) => false);
        }
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (cntx) => LoginScreen()),
          (route) => false);
    }
  }

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final AuthenticationService authenticationService = AuthenticationService();
  StreamSubscription userSub;

  void pushNavToLoginScreen({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (dynamic route) => false);
  }

  @override
  void initState() {
    super.initState();
    userSub = authenticationService.user
        .listen((event) => event ?? pushNavToLoginScreen(context: context));
  }

  @override
  void dispose() {
    userSub.cancel();
    super.dispose();
  }

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
        elevation: 5,
        backgroundColor: Colors.orange[800],
        title: Text(
          'Accueil',
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.all(5.0),
              icon: CircleAvatar(
                child: BackgroundImage(image: 'assets/images/logo.png'),
                backgroundColor: Colors.white,
              ),
              onPressed: null),
        ],
      ),
      drawer: Drawer(
        //menu
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.blue[600],
                  Colors.blue[900],
                ]),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 14),
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.01)),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconListTitle(
                Icons.home,
                'ACCUEIL',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Accueil()))),

            /*IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),*/
            IconListTitle(
                Icons.contacts,
                'CONTACT',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact()))),
            IconListTitle(widget.geticonfromuser(), "${getResponsefromuser()}",
                () => widget.getauthfromuser(context)),
            IconListTitle(
                Icons.help,
                'AIDE',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Accueil()))),
            /*IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
          ],
        ),
      ),
      body: Agriculteurwidget(myuser: widget.myuser, id: widget.myuser.id),
    );
  }
}
