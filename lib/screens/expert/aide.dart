/*import 'package:ctama/screens/accueil.dart';
import 'package:ctama/screens/contact.dart';
import 'package:ctama/screens/homeType/apicole/apicole.dart';
import 'package:ctama/screens/homeType/betail/betail.dart';
import 'package:ctama/screens/homeType/chambre/chambre.dart';
import 'package:ctama/screens/homeType/civilAgri/civilAgri.dart';
import 'package:ctama/screens/homeType/grele/grele.dart';
import 'package:ctama/screens/homeType/incendie/incendie.dart';
import 'package:ctama/screens/homeType/navire/navire.dart';
import 'package:ctama/screens/homeType/serres/serre.dart';
import 'package:ctama/screens/login-screen.dart';
import 'package:ctama/screens/profil.dart';
import 'package:ctama/screens/propos.dart';*/
import 'package:flutter/material.dart';

class Aide extends StatefulWidget {
  @override
  _AideState createState() => _AideState();
}

class _AideState extends State<Aide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text('Aide',
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
                backgroundImage:
                    NetworkImage('https://ctama.com.tn/assets/img/logo.png'),
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
          /*IconListTitle(Icons.home,'ACCUEIL',        ()=>Accueil()),
          IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),
          IconListTitle(Icons.contacts,'CONTACT',    ()=>Contact()),
          IconListTitle(Icons.logout,'DECONNEXION',  ()=>LoginScreen()),*/
          IconListTitle(Icons.help, 'AIDE', () => Aide()),
          /*IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
        ],
      )),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        childAspectRatio: 0.9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: <Widget>[
          /* assuranceType( 'https://cdn.shortpixel.ai/client/q_glossy,ret_img,w_737,h_415/https://www.trouverunassureur.com/wp-content/uploads/2018/08/grele-737x415.jpg',  'Assurance grêle',   ()=>Grele()),
                                 assuranceType( 'https://coolwallpapers.me/picsup/1495455-horse.jpg', 'Assurance mortalité du bétail',   ()=>Betail()),
                                 assuranceType( 'https://wallpaperaccess.com/full/1817788.jpg', 'Assurance incendie',   ()=>Incendie()),
                                 assuranceType( 'https://laituesmirabel.com/wp-content/uploads/2018/01/53.jpg', 'Mutirisques serres',   ()=>Serre()),
                                 assuranceType( 'https://inkyfada.com/wp-content/uploads/2020/11/petite-agriculture-cover-desktop-OPT.jpg', 'Responsabilité civile agriculteurs',   ()=>Civil()),
                                 assuranceType( 'https://images.pexels.com/photos/722995/pexels-photo-722995.jpeg?cs=srgb&dl=pexels-george-desipris-722995.jpg&fm=jpg', 'Corp navire de pêche',   ()=>Navire()),
                                 assuranceType( 'https://static.actu.fr/uploads/2019/06/AdobeStock_65760480.jpeg', 'Assurance multirisques apicole',   ()=>Apicole()),
                                 assuranceType( 'https://www.agenceair.pro/public/img/big/23jpg_5c6584e228ea4.jpg', 'Chambres frigorifiques',   ()=>Chambre()),*/
        ],
      ),
    );
  }

  Widget assuranceType(
    String img,
    String text1,
    Function onTap,
  ) {
    return Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      text1,
                      style: TextStyle(
                          fontFamily: 'home',
                          color: Colors.black,
                          fontSize: 9.999),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: new IconButton(
                      icon: new Icon(Icons.expand_more),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => onTap())),
                    ),
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}

class IconListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  IconListTitle(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0.8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.blue[100],
        ))),
        child: InkWell(
          splashColor: Colors.blue[400],
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => onTap())),
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
