import 'package:CTAMA/screens/WaitingScreen.dart';
import 'package:CTAMA/screens/accueil.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'backend/authentication_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CTAMA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  AuthenticationWrapper({Key key}) : super(key: key);

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final User user = authenticationService.getCurrentUser();
    return (user != null) ? WaitingS(uid: user.uid) : Accueil();
  }
}

/*authenticationService.authStateChanges.listen((user) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.push(
        context, 
        MaterialPageRoute(builder: (cntx)=>user!=null?Homepage():LoginScreen()),
    );
      });
    });
     
    return Center(child: CircularProgressIndicator()); */
