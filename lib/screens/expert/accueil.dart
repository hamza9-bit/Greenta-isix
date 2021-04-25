/*import 'package:ctama/screens/aide.dart';
import 'package:ctama/screens/contact.dart';
import 'package:ctama/screens/login-screen.dart';
import 'package:ctama/screens/profil.dart';
import 'package:ctama/screens/propos.dart';*/
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
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
              icon: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://ctama.com.tn/assets/img/logo.png'),
                backgroundColor: Colors.white,
              ),
              onPressed: null)
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
            /*IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),
          IconListTitle(Icons.contacts,'CONTACT',    ()=>Contact()),
          IconListTitle(Icons.logout,'DECONNEXION',  ()=>LoginScreen()),
          IconListTitle(Icons.help,'AIDE' ,          ()=>Aide()),
          IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: 200.0,
                            width: double.infinity,
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
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GridView.count(
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
