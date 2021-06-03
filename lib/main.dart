import 'dart:async';

import 'package:CTAMA/screens/WaitingScreen.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AuthenticationWrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Chargement de l'application CTAMA",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("Veuillez patienter quelques instants...",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[900]),
              strokeWidth: 4,
            )
          ],
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange[200], Colors.orange[200]],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
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
