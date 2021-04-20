import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agent/Agent-panel.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:flutter/material.dart';
import 'Agri_risque_formulaire.dart';
import 'login-screen.dart';


class DashboardScreen extends StatelessWidget {


  const DashboardScreen({Key key, this.myuser}) : super(key: key);

final Myuser myuser;

  void pushNavToLoginScreen({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (dynamic route) => false);
  }
  
  @override
  Widget build(BuildContext context) {
    return myuser.role==1? 
    Agent()
    :myuser.role == 0?
     myuser.risque? Dashboard() : FlightsStepper()
    :Material(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("EXPERT",style:TextStyle(fontSize: 20),),
            SizedBox(
              height: 50,
            ),
             MaterialButton(
              color: Colors.black.withOpacity(0.7),
              onPressed: ()async{
                AuthenticationService().signOut().then((value){
                    if (value){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (cntx)=>LoginScreen()), (route) => false);
                    }
                  });
              },
              child: Text("Log Out",style: TextStyle(color: Colors.white),),
            )
          ],
        )
      ),
    );
  }
}