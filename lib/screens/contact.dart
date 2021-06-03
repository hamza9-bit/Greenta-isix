import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/aide.dart';

import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/screens/viewagence.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  final Myuser myuser;
  final String id;

  const Contact({Key key, this.myuser, this.id}) : super(key: key);
  @override
  _ContactState createState() => _ContactState();
}

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

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text('Contact',
              style: TextStyle(
                color: Colors.orange[800],
              )),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.orange[900]),
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
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.white,
                Colors.blue[900],
              ]),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 14),
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.21)),
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
              ontap: () => getauthfromuser(context, widget.id, widget.myuser)),
          IconListTitle(
              icon: Icons.location_pin,
              text: 'NOS AGENCES',
              ontap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Viewagence()))),
          IconListTitle(
            icon: Icons.person,
            text: 'MON PANNEAU',
            ontap: () => getlogfromuser(context, widget.id, widget.myuser),
          )
        ],
      )),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        childAspectRatio: 0.9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: <Widget>[
          assuranceType('https://img.phonandroid.com/2019/03/gmail-1.jpg',
              'mailto:ctama@planet.tn'),
          assuranceType(
              'https://c2g8v2d7.rocketcdn.me/wp-content/uploads/2019/07/fonctionnalites-facebook.png',
              "https://www.facebook.com/Assurances-CTAMA-747695268706974/"),
          assuranceType('https://pic.clubic.com/v1/images/1675226/raw',
              "https://www.google.com/search?sxsrf=ALeKk02JEyziH2z1WZydmYKP4V2bzNIIuw:1619489099407&q=siege+ctama+localisation&npsic=0&rflfq=1&rldoc=1&rlha=0&rllag=36825101,10178370,2598&tbm=lcl&sxsrf=ALeKk02JEyziH2z1WZydmYKP4V2bzNIIuw:1619489099407&sa=X&ved=2ahUKEwjh-vKDq53wAhV7gf0HHQELBGUQtgN6BAgEEAc&biw=1280&bih=578#rlfi=hd:;si:;mv:[[36.8513689,10.187152800000002],[36.7975139,10.177197999999999]];tbs:lrf:!1m4!1u2!2m2!2m1!1e1!2m1!1e2!3sIAE,lf:1,lf_ui:2"),
          assuranceType(
              'https://www.snopes.com/tachyon/2020/10/Featured-Image-Templates95.png',
              'tel:70556800'),
        ],
      ),
    );
  }

  Widget assuranceType(
    String img,
    String url,
  ) {
    return Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 1,
            child: Container(
                child: GestureDetector(
                  onTap: () async {
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: DecorationImage(
                      image: new NetworkImage(img),
                      fit: BoxFit.fill,
                    ))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 1.0),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
