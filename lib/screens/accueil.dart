import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/aide.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Accueil extends StatefulWidget {
  final Myuser myuser;

  const Accueil({Key key, this.myuser}) : super(key: key);
  @override
  _AccueilState createState() => _AccueilState();
}

String getResponsefromuser() {
  final AuthenticationService authenticationService = AuthenticationService();
  final User user = authenticationService.getCurrentUser();
  return user != null ? "DECONNEXION" : "SE CONNECTER";
}

class _AccueilState extends State<Accueil> {
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
            IconListTitle(Icons.home, 'ACCUEIL', () => Accueil()),
            /*IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),*/
            IconListTitle(Icons.contacts, 'CONTACT', () => Contact()),
            IconListTitle(
                Icons.logout, "${getResponsefromuser()}", () => LoginScreen()),
            IconListTitle(Icons.help, 'AIDE', () => Aide()),
            /*IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
          ],
        ),
      ),
      body: SafeArea(
        // nasfah ama mo9bilika 3imlt bel vertical tsal7et chaya
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: SizedBox(
                      child: Carousel(
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomRight,
                    images: [
                      Image.asset(
                        'assets/images/slide1.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/slide5.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/slide2.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/slide4.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/slide5.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/slide11.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                  )),
                ), //k tzid sizedbox teb3d wela kifh  ey tsawer zouz louleni yahbtou chwaya 3al slides

                Expanded(flex: 6, child: Aide())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
