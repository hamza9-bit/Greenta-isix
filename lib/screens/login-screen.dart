import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Admin-Panel.dart';
import 'package:CTAMA/screens/WaitingScreen.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/viewagence.dart';
import 'package:CTAMA/widgets/iconliste.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/widgets/widgets.dart';
import 'create-new-account.dart';
import 'forgot-password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final Myuser myuser;
  final String id;

  LoginScreen({Key key, this.myuser, this.id}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final AuthenticationService authenticationService = AuthenticationService();

  String email;

  String pass;

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (cntx) => LoginScreen(
                        id: widget.id,
                        myuser: widget.myuser,
                      )));
        }
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (cntx) => LoginScreen(
                  id: widget.id,
                  myuser: widget.myuser,
                )),
      );
    }
  }

  void showtoast(String msg, Color color) async {
    toast.Fluttertoast.showToast(
        msg: msg, backgroundColor: color, gravity: toast.ToastGravity.TOP);
  }

  void pushNavToDash({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (cntx) => WaitingS(
                  uid: authenticationService.getCurrentUser().uid,
                )),
        (dynamic route) => false);
  }

  void validate(BuildContext context) async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (email == "00000000@gmail.com" && pass == "00000000") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (cntx) => Admin()),
            (dynamic route) => false);
      } else {
        authenticationService
            .signIn(email: email, password: pass)
            .then((value) => value ? pushNavToDash(context: context) : "");
      }
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/login_bg.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.01)),
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
                  ontap: () =>
                      getlogfromuser(context, widget.id, widget.myuser),
                )
                /*IconListTitle(Icons.feedback,'A PROPOS' ,  ()=>Propos()),*/
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(
                    height: height / 8.43,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'CTAMA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height / 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextInputField(
                          onSaved: (String myemail) => email = myemail,
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Veuillez saisir une adresse mail"),
                            EmailValidator(
                                errorText:
                                    "Veuillez saisir une adresse mail valide"),
                          ])),
                      PasswordInput(
                        onSaved: (String mypassword) => pass = mypassword,
                        icon: FontAwesomeIcons.lock,
                        hint: 'Mot De Passe',
                        inputAction: TextInputAction.done,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword())),
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                              fontSize: 22, color: Colors.white, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: RoundedButton(
                          buttonName: 'Se connecter',
                          ontap: () => validate(context),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewAccount())),
                    child: Container(
                      child: Text(
                        'Creer un nouveau compte',
                        style: TextStyle(
                            fontSize: 22, color: Colors.white, height: 1.5),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.white))),
                    ),
                  ),
                  SizedBox(
                    height: height / 42.15,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
