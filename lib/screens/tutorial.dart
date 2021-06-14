import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/screens/viewagence.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroSliderPage extends StatefulWidget {
  final Myuser myuser;
  final String id;

  const IntroSliderPage({Key key, this.myuser, this.id}) : super(key: key);
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
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

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(
      new Slide(
        title: "S'authentifier!",
        description:
            "Pour inscrivez,il suffit de remplir le formulaire d'inscription.",
        pathImage: "assets/images/login.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Déclarer les risques",
        description:
            "Pour déclarez vos risques,il suffit de répondre aux questions nécessaires.",
        pathImage: "assets/images/sonbla.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Préciser parcelle",
        description:
            "Utiliser les outils de Google Maps pour préciser les frontiéres de votre parcelle.",
        pathImage: "assets/images/raw.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "Déclarer les sinistres",
        description:
            "En cas du sinistre, N'hesitez pas de nous informer le plus tôt possible.",
        pathImage: "assets/images/piw.png",
      ),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 160, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    currentSlide.pathImage,
                    matchTextDirection: true,
                    height: 60,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    currentSlide.title,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Text(
                    currentSlide.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aide"),
        elevation: 0,
        backgroundColor: Colors.orange[900],
        iconTheme: IconThemeData(color: Colors.white),
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

            /*IconListTitle(Icons.person,'MON COMPTE',   ()=>Profil()),*/
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
      body: IntroSlider(
        backgroundColorAllSlides: Colors.blue[900],
        renderSkipBtn: Text("Passer"),
        renderNextBtn: Text(
          "Suivant",
          style: TextStyle(color: Colors.orange[900]),
        ),
        renderDoneBtn: Text(
          "Prêt",
          style: TextStyle(color: Colors.orange[900]),
        ),
        colorDoneBtn: Colors.white,
        colorActiveDot: Colors.white,
        sizeDot: 8.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        listCustomTabs: this.renderListCustomTabs(),
        scrollPhysics: BouncingScrollPhysics(),
        onDonePress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Accueil(),
          ),
        ),
      ),
    );
  }
}
