import 'dart:async';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/NosAgences.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/agr-sinsitres.dart';
import 'package:CTAMA/screens/aide.dart';
import 'package:CTAMA/screens/ajouter-agence.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/saved_parcelle_ag.dart';
import 'package:CTAMA/screens/tutorial.dart';

import 'package:CTAMA/screens/viewagence.dart';
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

  void getlogfromuser(BuildContext context, String id, Myuser myuser) async {
    final AuthenticationService authenticationService = AuthenticationService();
    final User user = authenticationService.getCurrentUser();
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (cntx) => LoginScreen()),
          (route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (cntx) => Dashboard(
                  id: id,
                  myuser: myuser,
                )),
      );
    }
  }

  void getauthfromuser(BuildContext context, String id, Myuser myuser) async {
    final AuthenticationService authenticationService = AuthenticationService();
    final User user = authenticationService.getCurrentUser();
    if (user != null) {
      AuthenticationService().signOut().then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (cntx) => LoginScreen(
                        id: id,
                        myuser: myuser,
                      )),
              (dynamic route) => false);
        }
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (cntx) => LoginScreen(
                    id: id,
                    myuser: myuser,
                  )),
          (dynamic route) => false);
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.orange[800],
          title: Text(
            "Panneau d'agriculteur",
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
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            labelPadding: EdgeInsets.only(bottom: 10),
            unselectedLabelColor: Colors.blue[500],
            tabs: [
              Text(
                'Parcelles',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Sinistres',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
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
                  icon: Icons.home,
                  text: 'ACCUEIL',
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(
                                id: widget.id,
                                myuser: widget.myuser,
                              )))),

              /*IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),*/
              IconListTitle(
                  icon: Icons.contacts,
                  text: 'CONTACT',
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Contact(
                                id: widget.id,
                                myuser: widget.myuser,
                              )))),
              IconListTitle(
                  icon: widget.geticonfromuser(),
                  text: "${widget.getResponsefromuser()}",
                  ontap: () => widget.getauthfromuser(
                      context, widget.id, widget.myuser)),
              IconListTitle(
                  icon: Icons.location_pin,
                  text: 'NOS AGENCES',
                  ontap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Viewagence()))),
              IconListTitle(
                icon: Icons.person,
                text: 'MON PANNEAU',
                ontap: () =>
                    widget.getlogfromuser(context, widget.id, widget.myuser),
              ),
              IconListTitle(
                  icon: Icons.help,
                  text: 'AIDE',
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroSliderPage(
                                id: widget.id,
                                myuser: widget.myuser,
                              )))),
              /*IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            SavedParcelleag(
              uid: widget.myuser.id,
            ),
            AgriSinistre(
              cin: widget.myuser.cin,
              iamAgri: true,
              nbsin: widget.myuser.nbSinisitre,
              readOnly: true,
              uid: widget.myuser.id,
            )
          ]),
        ),
      ),
    );
  }
}
