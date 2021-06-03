import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/widgets/background-image.dart';
import 'package:CTAMA/widgets/rounded-button.dart';
import 'package:CTAMA/widgets/text-field-input.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthenticationService authenticationService = AuthenticationService();
  final DatabaseService databaseService = DatabaseService();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email = '';
  void pushNavToDash({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (dynamic route) => false);
  }

  void validate2(BuildContext context) async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      authenticationService.resetpassword(email).then(
          (value) => value ? pushNavToDash(context: context) : print("FAIL"));
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/login_bg.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Réinitialiser mot de passe',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Text(
                            'Entrez votre Email et nous vous envoyons les instructions pour Réinitialiser votre Mot de Passe',
                            style: TextStyle(
                                fontSize: 22, color: Colors.white, height: 1.5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputField(
                          onSaved: (String myemail) => email = myemail,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Veuillez saisir une adresse mail"),
                            EmailValidator(
                                errorText:
                                    "Veuillez saisir une adresse mail valid"),
                          ]),
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: RoundedButton(
                            buttonName: 'Envoyer',
                            ontap: () => validate2(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
