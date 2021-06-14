import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/aide.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/screens/tutorial.dart';
import 'package:CTAMA/screens/viewagence.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Accueil extends StatefulWidget {
  final Myuser myuser;
  final String id;
  const Accueil({Key key, this.myuser, this.id}) : super(key: key);
  @override
  _AccueilState createState() => _AccueilState();
}
/*getlogfromuser(BuildContext context){

 final AuthenticationService authenticationService = AuthenticationService();
  final User user = authenticationService.getCurrentUser();
    return (user != null) ? Dashboard(
                              id: id,
                              myuser: myuser,
                            ) : LoginScreen();
}*/

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

void getauthfromuser(BuildContext context, String id, Myuser myuser) async {
  final AuthenticationService authenticationService = AuthenticationService();
  final User user = authenticationService.getCurrentUser();
  if (user != null) {
    AuthenticationService().signOut().then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (cntx) => LoginScreen(
                    id: id,
                    myuser: myuser,
                  )),
        );
      }
    });
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (cntx) => LoginScreen(
                id: id,
                myuser: myuser,
              )),
    );
  }
}

void getlogfromuser(BuildContext context, String id, Myuser myuser) async {
  final AuthenticationService authenticationService = AuthenticationService();
  final User user = authenticationService.getCurrentUser();
  if (user == null) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()), (route) => false);
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

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: geticonfromuser(),
                text: "${getResponsefromuser()}",
                ontap: () =>
                    getauthfromuser(context, widget.id, widget.myuser)),
            IconListTitle(
                icon: Icons.location_pin,
                text: 'NOS AGENCES',
                ontap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Viewagence()))),
            IconListTitle(
              icon: Icons.person,
              text: 'MON PANNEAU',
              ontap: () => getlogfromuser(context, widget.id, widget.myuser),
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
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.orange[800],
            title: Text('Accueil'),
            centerTitle: false,
            floating: true,
            pinned: true,
            expandedHeight: 250,
            actions: [
              IconButton(
                  padding: EdgeInsets.all(5.0),
                  icon: CircleAvatar(
                    child: BackgroundImage(image: 'assets/images/logo.png'),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: null),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Carousel(
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
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: Aide(),
          ),
        ],
      )),
    );
  }
}
